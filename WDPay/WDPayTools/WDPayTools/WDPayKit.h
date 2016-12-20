//
//  WDPayTools.h
//  WDPayTools
//
//  Created by Blake on 15/11/9.
//  Copyright © 2015年 Blake. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AL_KEY_PARTNER @""
#define AL_KEY_SELLER @""
#define AL_KEY_PAIVATEKEY @""
#define AL_KEY_NOTIFY_URL @""
#define AL_KEY_APP_SCHEME @""

#define UP_KEY_MODE @""

typedef enum : NSUInteger {
    KWDPAYTYPE_ALI,//支付宝
    KWDPAYTYPE_WX,//微信
    KWDPAYTYPE_UN,//银联
} KWDPAYTYPE;

typedef void(^WDPayComplicationBlock)(NSDictionary* resultDic);

@interface WDPayKit : NSObject

+(instancetype)shareInstance;

- (BOOL)handleOpenUrl:(NSURL*)url WithComplication:(WDPayComplicationBlock)resultBlock;


- (void)creatAlPayWithTradeNO:(NSString*)tradeNo
                  productName:(NSString*)productName
           productDescription:(NSString*)productDescription
                       amount:(NSString*)amount
                 complication:(WDPayComplicationBlock)resultBlock;

/**
 *  支付宝支付
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

/**
 *  银联支付
 *
 *  @param tradeString    tn
 *  @param viewController vc
 *  @param resultBlock    result
 */
- (void)creatAlPayWithTradeString:(NSString *)tradeString
                   viewController:(UIViewController *)viewController
                     complication:(WDPayComplicationBlock)resultBlock;

/**
 *  微信支付
 *
 *  @param paymentDic  服务器返回的字典
 *  @param resultBlock 结果block
 */
- (void)creatWXPayWithPaymentDic:(NSDictionary*)paymentDic
             complication:(WDPayComplicationBlock)resultBlock;



@end
