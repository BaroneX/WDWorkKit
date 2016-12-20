//
//  WDSystemInfo.h
//  WDFrameWork
//
//  Created by Blake on 15/3/12.
//  Copyright (c) 2015年 Blake. All rights reserved.
//
//系统信息相关类

#import <Foundation/Foundation.h>

@interface WDSystemInfo : NSObject
//判断系统版本
#define IOS9_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending )
#define IOS8_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define IOS7_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS6_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define IOS5_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
#define IOS4_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"4.0"] != NSOrderedAscending )
#define IOS3_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"3.0"] != NSOrderedAscending )

#define IOS8_OR_EARLIER		( !IOS9_OR_LATER )
#define IOS7_OR_EARLIER		( !IOS8_OR_LATER )
#define IOS6_OR_EARLIER		( !IOS7_OR_LATER )
#define IOS5_OR_EARLIER		( !IOS6_OR_LATER )
#define IOS4_OR_EARLIER		( !IOS5_OR_LATER )
#define IOS3_OR_EARLIER		( !IOS4_OR_LATER )

#define IS_SCREEN_4_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640/2, 1136/2), [[UIScreen mainScreen] bounds].size) : NO)
#define IS_SCREEN_35_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640/2, 960/2),  [[UIScreen mainScreen] bounds].size) : NO)
#define DiffHeight (IS_SCREEN_4_INCH ? 88 : 0) //(1136-960)/2


#define WinSize     [UIScreen mainScreen].bounds.size
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//越狱判断是否有此文件夹
#define USER_APP_PATH @"/User/Applications/"

/**
 *  获取设备标识符
 *
 *  @return 设备标示符
 */
+ (NSString *)deviceIdentifier;

/**
 *  获取iOS系统版本号
 *
 *  @return iOS系统版本号
 */
+ (NSString *)iOSVersion;

/**
 *  获取应用版本号
 *
 *  @return 应用版本号
 */
+ (NSString *)appVersion;

/**
 *  获取应用标识符
 *
 *  @return 应用标识符
 */
+ (NSString *)appIdentifier;

/**
 *  获取手机操作系统类型
 *
 *  @return 手机操作系统类型
 */
+ (NSString *)osType;

/**
 * 手机是否越狱
 *
 *  @return 手机是否越狱
 */
+(BOOL)isJailBreak;

/**
 *  手机model iphone ipod touch...
 *
 *  @return model
 */
+(NSString*)getCurrentDeviceModel;


+(NSString*)localeIdentifier;


@end
