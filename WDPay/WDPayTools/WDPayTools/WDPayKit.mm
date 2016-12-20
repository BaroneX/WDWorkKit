//
//  WDPayTools.m
//  WDPayTools
//
//  Created by Blake on 15/11/9.
//  Copyright © 2015年 Blake. All rights reserved.
//

#import "WDPayKit.h"
#import "ALPayOrder.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

#import "UPPayPlugin.h"
#import "WXApi.h"

@interface WDPayKit ()<UPPayPluginDelegate,WXApiDelegate>
{

    WDPayComplicationBlock _resultBlock;
    
}
@end

@implementation WDPayKit

+(instancetype)shareInstance{
    
    static WDPayKit* tools;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [WDPayKit new];
    });
    return tools;
}

- (BOOL)handleOpenUrl:(NSURL*)url WithComplication:(WDPayComplicationBlock)resultBlock;
{

    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"sourceApplicationResult = %@",resultDic);
        }];
        return YES;
    }else{
    
        _resultBlock = nil;
        _resultBlock = resultBlock;
        [WXApi handleOpenURL:url delegate:self];
        return YES;
    }

    return NO;

}
#pragma mark - 支付宝支付
/**
 *
 *  @param tradeNo            订单号
 *  @param productName        商品名称
 *  @param productDescription 商品描述
 *  @param amount             商品金额
 *  @param resultBlock        结果block
 */
- (void)creatAlPayWithTradeNO:(NSString*)tradeNo
                  productName:(NSString*)productName
           productDescription:(NSString*)productDescription
                       amount:(NSString*)amount
                 complication:(WDPayComplicationBlock)resultBlock;
{

    NSString* orderString = [self getAlPayOrderStringWithtradeNo:tradeNo
                             productName:productName
                      productDescription:productDescription
                                  amount:amount];
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = AL_KEY_APP_SCHEME;
    
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        resultBlock(resultDic);
    }];

}

- (NSString*)getAlPayOrderStringWithtradeNo:(NSString*)tradeNo
                                productName:(NSString*)productName
                         productDescription:(NSString*)productDescription
                                     amount:(NSString*)amount;
{
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    ALPayOrder *order = [[ALPayOrder alloc] init];
    order.partner = AL_KEY_PARTNER;
    order.seller = AL_KEY_SELLER;
    order.notifyURL =  AL_KEY_NOTIFY_URL; //回调URL
    
    
    order.tradeNO = tradeNo; //订单ID（由商家自行制定）
    order.productName = productName; //商品标题
    order.productDescription =productDescription; //商品描述
    order.amount = [NSString stringWithFormat:@"%@",amount]; //商品价格

    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(AL_KEY_PAIVATEKEY);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        return orderString;
    }
    
    return nil;
}

#pragma mark -   银联支付
/**
 *
 *  @param tradeString    tn
 *  @param viewController vc
 *  @param resultBlock    result
 */
- (void)creatAlPayWithTradeString:(NSString *)tradeString
                   viewController:(UIViewController *)viewController
                     complication:(WDPayComplicationBlock)resultBlock;
{
    
    _resultBlock = nil;
    _resultBlock = resultBlock;
    
    [UPPayPlugin startPay:tradeString mode:UP_KEY_MODE viewController:viewController delegate:self];
    
}
-(void)UPPayPluginResult:(NSString*)result;
{
    NSDictionary* resultDic = @{@"result":result};
    _resultBlock(resultDic);
    
}
#pragma mark - 微信支付
/**
 *
 *  @param paymentDic  服务器返回的字典
 *  @param resultBlock 结果block
 */
- (void)creatWXPayWithPaymentDic:(NSDictionary*)paymentDic
                    complication:(WDPayComplicationBlock)resultBlock;
{
    
    _resultBlock = nil;
    _resultBlock = resultBlock;
    
    NSMutableString *stamp  = [paymentDic objectForKey:@"timestamp"];
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = [paymentDic objectForKey:@"appid"];
    req.partnerId           = [paymentDic objectForKey:@"partnerid"];
    req.prepayId            = [paymentDic objectForKey:@"prepayid"];
    req.nonceStr            = [paymentDic objectForKey:@"noncestr"];
    req.timeStamp           = stamp.intValue;
    req.package             = [paymentDic objectForKey:@"package"];
    req.sign                = [paymentDic objectForKey:@"sign"];
    
    [WXApi sendReq:req];

}

-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
//        _resultBlock(@{@"result":BaseResp});
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
    
}

@end
