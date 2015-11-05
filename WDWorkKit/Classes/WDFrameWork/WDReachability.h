//
//  WDReachability.h
//  WDFrameWork
//
//  Created by Blake on 15/3/12.
//  Copyright (c) 2015年 Blake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDReachability : NSObject

+ (WDReachability *)sharedInstance;
/**
 *  检测网络是否可以连接
 *
 *  @return 可以连接返回YES,否则NO
 */
+ (BOOL)isReachable;

/**
 *  检测网络是否通过wifi连接
 *
 *  @return 通过wifi连接返回YES,否则NO
 */
+ (BOOL)isReachableViaWIFI;

/**
 *  检测网络是否通过移动网络连接
 *
 *  @return 通过移动网络连接返回YES,否则NO
 */
+ (BOOL)isReachableViaWLAN;

/**
 *  返回终端的ip地址
 *
 *  @return ip地址
 */
+ (NSString *)localIP;

@end
