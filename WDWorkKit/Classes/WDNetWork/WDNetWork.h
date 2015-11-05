//
//  WDNetWork.h
//  WDNetWork
//
//  Created by Blake on 15/3/30.
//  Copyright (c) 2015年 Blake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^WDSuccessResponseBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^WDFailResponseBlock)(NSError* error);

@interface WDNetWork : NSObject
/**
 *  获取network实例
 *
 *  @return network实例
 */
+ (WDNetWork *)sharedInstance;

/**
 *  GET请求json数据
 *
 *  @param URLString  请求URL地址
 *  @param parameters 请求参数
 *  @param success    请求成功的处理函数
 *  @param failure    请求失败的处理函数
 */
- (void)getJSONDataWithUrl:(NSString *)URLString
                parameters:(NSDictionary *)parameters
                   success:(WDSuccessResponseBlock)success
                   failure:(WDFailResponseBlock)failure;

/**
 *  GET请求
 *  @param URLString  请求URL地址
 *  @param parameters 请求参数
 *  @param success    请求成功的处理函数
 *  @param failure    请求失败的处理函数
 */
- (void)getDataWithUrl:(NSString *)URLString
                parameters:(NSDictionary *)parameters
                   success:(WDSuccessResponseBlock)success
                   failure:(WDFailResponseBlock)failure;

/**
 *  POST请求json数据
 *
 *  @param URLString  请求URL地址
 *  @param parameters 请求参数
 *  @param success    请求成功的处理函数
 *  @param failure    请求失败的处理函数
 */
- (void)postJSONDataWithUrl:(NSString *)URLString
                parameters:(NSDictionary *)parameters
                   success:(WDSuccessResponseBlock)success
                   failure:(WDFailResponseBlock)failure;

/**
 *  POST请求
 *
 *  @param URLString  请求URL地址
 *  @param parameters 请求参数
 *  @param success    请求成功的处理函数
 *  @param failure    请求失败的处理函数
 */
- (void)postDataWithUrl:(NSString *)URLString
                 parameters:(NSDictionary *)parameters
                    success:(WDSuccessResponseBlock)success
                    failure:(WDFailResponseBlock)failure;

/**
 *  将数据以表单的形式上传到服务器
 *
 *  @param URLString 请求URL地址
 *  @param data      上传的表单数据
 *  @param success   请求成功的处理函数
 *  @param failure   请求失败的处理函数
 */
- (void)postMultiFormDataWithUrl:(NSString*)URLString
                        FormData:(NSData*)data
                         success:(WDSuccessResponseBlock)success
                         failure:(WDFailResponseBlock)failure;

/**
 *  取消AFNetworking的网络请求
 */
- (void)cancelAFURLRequest;

/**
 *  设置网络请求的超时时间
 *
 *  @param time 超时时间
 */
-(void)setValidationTimeInternal:(NSInteger)time;

@end
