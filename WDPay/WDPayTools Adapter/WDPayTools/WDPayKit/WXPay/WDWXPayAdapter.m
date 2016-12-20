//
//  WDWXPayAdapter.m
//  WDPayTools
//
//  Created by Blake on 15/11/12.
//  Copyright © 2015年 Blake. All rights reserved.
//

#import "WDWXPayAdapter.h"
#import "WXApi.h"
#import "WDPayResult.h"
@interface WDWXPayAdapter ()<WDPayAdapterDelegate,WXApiDelegate>
{
    
    WDPayComplicationBlock _resultBlock;
    
}
@end

@implementation WDWXPayAdapter


+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static WDWXPayAdapter *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[WDWXPayAdapter alloc] init];
    });
    return instance;
}

- (BOOL)handleOpenUrl:(NSURL *)url withComplication:(WDPayComplicationBlock)resultBlock;
{
    _resultBlock = nil;
    _resultBlock = resultBlock;
    return [WXApi handleOpenURL:url delegate:[WDWXPayAdapter shareInstance]];
    
}

-(void)createPayment:(NSMutableDictionary *)paymentDic viewController:(UIViewController *)viewController complication:(WDPayComplicationBlock)resultBlock{
    
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
    
    WDPayResult* result = [WDPayResult new];
    
    if (_resultBlock) {
        _resultBlock(result);
    }
    
}




@end
