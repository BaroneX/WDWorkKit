//
//  WDPayTools.m
//  WDPayTools
//
//  Created by Blake on 15/11/9.
//  Copyright © 2015年 Blake. All rights reserved.
//

#import "WDPayKit.h"

@interface WDPayKit ()
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

- (BOOL)handleOpenUrl:(NSURL*)url withComplication:(WDPayComplicationBlock)resultBlock;
{

    if ([url.host isEqualToString:@"safepay"]){

      id adapter = [NSClassFromString(kAdapterAliPay) shareInstance];
        if (adapter && [adapter respondsToSelector:@selector(handleOpenUrl:withComplication:)]) {
           return  [adapter handleOpenUrl:url withComplication:resultBlock];
        }
        
        return NO;
    }
    else if ([url.scheme hasPrefix:@"wx"] && [url.host isEqualToString:@"pay"]){

        id adapter = [NSClassFromString(kAdapterWXPay) shareInstance];
        if (adapter && [adapter respondsToSelector:@selector(handleOpenUrl:withComplication:)]) {
            return  [adapter handleOpenUrl:url withComplication:resultBlock];
        }
        
        return NO;
    }

    return NO;
}

- (void)creatPaymentByType:(KWDPayType)payType
                   withDic:(NSMutableDictionary*)dic
            viewController:(UIViewController*)viewController
              complication:(WDPayComplicationBlock)resultBlock{
    
    id adapter;
    switch (payType) {
        case KWDPayType_ALI:
        {
            adapter = [NSClassFromString(kAdapterAliPay) shareInstance];
        }
            break;
        case KWDPayType_WX:
        {
            adapter = [NSClassFromString(kAdapterWXPay) shareInstance];
        }
            break;
        case KWDPayType_UN:
        {
            adapter = [NSClassFromString(kAdapterUnionPay) shareInstance];
        }
            break;
        default:
            break;
    }
    
    if (adapter && [adapter respondsToSelector:@selector(createPayment:viewController:complication:)]) {
        [adapter createPayment:dic viewController:viewController complication:resultBlock];
    }
    
}

@end
