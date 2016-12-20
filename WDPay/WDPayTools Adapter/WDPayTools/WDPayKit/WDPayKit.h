//
//  WDPayTools.h
//  WDPayTools
//
//  Created by Blake on 15/11/9.
//  Copyright © 2015年 Blake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDPayConfig.h"

@interface WDPayKit : NSObject

+(instancetype)shareInstance;

- (BOOL)handleOpenUrl:(NSURL*)url withComplication:(WDPayComplicationBlock)resultBlock;

- (void)creatPaymentByType:(KWDPayType)payType
                   withDic:(NSMutableDictionary*)dic
            viewController:(UIViewController*)viewController
               complication:(WDPayComplicationBlock)resultBlock;

@end
