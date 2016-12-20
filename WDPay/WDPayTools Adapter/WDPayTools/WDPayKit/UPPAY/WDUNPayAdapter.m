//
//  WDUNPayAdapter.m
//  WDPayTools
//
//  Created by Blake on 15/11/12.
//  Copyright © 2015年 Blake. All rights reserved.
//

#import "WDUNPayAdapter.h"
#import "UPPayPlugin.h"
#import "UPPayPluginDelegate.h"
#import "WDPayResult.h"
@interface WDUNPayAdapter ()<WDPayAdapterDelegate,UPPayPluginDelegate>
{

    WDPayComplicationBlock _resultBlock;

}
@end

@implementation WDUNPayAdapter

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static WDUNPayAdapter *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[WDUNPayAdapter alloc] init];
    });
    return instance;
}

-(void)createPayment:(NSMutableDictionary *)dic viewController:(UIViewController *)viewController complication:(WDPayComplicationBlock)resultBlock{
    
    _resultBlock = nil;
    _resultBlock = resultBlock;
    
    NSString *tn = [dic objectForKey:@"tn"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UPPayPlugin startPay:tn mode:UP_KEY_MODE viewController:viewController delegate:[WDUNPayAdapter shareInstance]];
    });
}

-(void)UPPayPluginResult:(NSString*)resultString;
{
    
    WDPayResult* result = [WDPayResult new];

    
    _resultBlock(result);
}

@end








