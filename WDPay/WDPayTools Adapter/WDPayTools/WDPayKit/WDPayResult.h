//
//  WDPayResult.h
//  WDPayTools
//
//  Created by Blake on 15/11/12.
//  Copyright © 2015年 Blake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDPayConfig.h"

/**
 *  交易结果
 */
@interface WDPayResult : NSObject

/**
 *  交易类型
 */
@property(nonatomic,assign)KWDPayType payType;

/**
 *  交易结果码
 */
@property(nonatomic,assign)WDResultCode resultCode;

/**
 *  交易结果信息
 */
@property(nonatomic,copy)NSString* resultMessage;

/**
 *  交易结果map
 */
@property(nonatomic,strong)NSDictionary* resultDic;

@end
