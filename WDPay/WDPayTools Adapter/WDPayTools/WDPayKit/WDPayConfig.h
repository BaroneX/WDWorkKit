//
//  WDPayConfig.h
//  WDPayTools
//
//  Created by Blake on 15/11/12.
//  Copyright © 2015年 Blake. All rights reserved.
//

#ifndef WDPayConfig_h
#define WDPayConfig_h
@class WDPayResult;

#define AL_KEY_PARTNER @""
#define AL_KEY_SELLER @""
#define AL_KEY_PAIVATEKEY @""
#define AL_KEY_NOTIFY_URL @""
#define AL_KEY_APP_SCHEME @""

#define UP_KEY_MODE @""

//Adapter
static NSString * const kAdapterWXPay = @"WDWXPayAdapter";
static NSString * const kAdapterAliPay = @"WDALPayAdapter";
static NSString * const kAdapterUnionPay = @"WDUnionPayAdapter";

typedef void(^WDPayComplicationBlock)(WDPayResult* result);

typedef enum : NSUInteger {
    KWDPayType_ALI,//支付宝
    KWDPayType_WX,//微信
    KWDPayType_UN,//银联
} KWDPayType;

typedef enum : NSUInteger {
    KWDResultCodeSuccess,
    KWDResultCodeFail,
    KWDResultCodeCancel,
} WDResultCode;



@protocol WDPayAdapterDelegate <NSObject>

@required

+(instancetype)shareInstance;

@optional

- (BOOL)handleOpenUrl:(NSURL *)url withComplication:(WDPayComplicationBlock)resultBlock;

- (void)createPayment:(NSMutableDictionary *)dic
       viewController:(UIViewController*)viewController
         complication:(WDPayComplicationBlock)resultBlock;

@end

#endif /* WDPayConfig_h */







