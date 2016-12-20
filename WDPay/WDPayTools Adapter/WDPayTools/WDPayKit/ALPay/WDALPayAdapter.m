//
//  WDALpayAdatper.m
//  WDPayTools
//
//  Created by Blake on 15/11/12.
//  Copyright © 2015年 Blake. All rights reserved.
//

#import "WDALPayAdapter.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WDPayResult.h"

@interface WDALPayAdapter ()<WDPayAdapterDelegate>
{

    WDPayComplicationBlock _resultBlock;

}
@end

@implementation WDALPayAdapter


+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static WDALPayAdapter *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[WDALPayAdapter alloc] init];
    });
    return instance;
}

- (BOOL)handleOpenUrl:(NSURL *)url withComplication:(WDPayComplicationBlock)resultBlock;
{
    
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            _resultBlock = nil;
            _resultBlock = resultBlock;
            [[WDALPayAdapter shareInstance]processOrderForAliPay:resultDic];
    }];
    
    return YES;
}

-(void)createPayment:(NSMutableDictionary *)dic viewController:(UIViewController *)viewController complication:(WDPayComplicationBlock)resultBlock{
    
    _resultBlock = nil;
    _resultBlock = resultBlock;
    
    NSString* orderString = [dic objectForKey:@"orderString"];
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = AL_KEY_APP_SCHEME;
 
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            [[WDALPayAdapter shareInstance]processOrderForAliPay:resultDic];
    }];

}

- (void)processOrderForAliPay:(NSDictionary *)resultDic
{

    WDPayResult* result = [WDPayResult new];
    
    
    
    if (_resultBlock) {
        _resultBlock(result);
    }

}


@end
