//
//  NSString+Addition.h
//  MSZXFramework
//
//  Created by wenyanjie on 14-12-17.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Addition)

/**
 *  判断字符串是否为空或nil
 *
 *  @param string 待判断的字符串
 *
 *  @return 结果
 */
+ (BOOL)strNilOrEmpty:(NSString *)aString;

/**
 *  生成随机字符串(大小写字母加数字)
 *
 *  @param length 随机字符串长度
 *
 *  @return 随机字符串
 */
+ (NSString *)randomAlphaNumericStringWithLength:(NSInteger)length;

/**
 *  除去字符串开头和末尾的空格
 *
 *  @return 除去空格后的字符串
 */
- (NSString *)trim;

#pragma mark - 有效值校验

/**
 *  邮件地址是否有效
 *
 *  @return YES有效,NO无效
 */
- (BOOL)isValidEmail;

/**
 *  手机号是否有效
 *
 *  @return YES手机号有效,NO手机号无效
 */
- (BOOL)isVAlidPhoneNumber;

/**
 *  车牌是否有效
 *
 *  @return YES手机号有效,NO手机号无效
 */
- (BOOL)isVAlidCarNumber;

/**
 *  url是否有效
 *
 *  @return YES url有效,NO url无效
 */
- (BOOL)isValidUrl;

- (BOOL)isVAlidChineseHZ;

#pragma mark -  hash算法
/**
 *  md5转换
 *
 *  @return md5值
 */
- (NSString *)stringMD5;

/**
 *  sha1转换
 *
 *  @return sha1值
 */
- (NSString *)sha1;

/**
 *  返回base64字符(编码)
 *
 *  @return base64string
 */
- (NSString*)base64Encode;

/**
 *  返回解码后的base64字符
 *
 *  @return 解码base64
 */
- (NSString*)base64Decode;

/**
 *  sha256转换
 *
 *  @return sha256值
 */
- (NSString *)sha256;

/**
 *  sha512转换
 *
 *  @return sha512值
 */
- (NSString *)sha512;

/**
 *  计算文件的MD5
 *
 *  @param path 文件路径
 *
 *  @return 文件md5值
 */
- (NSString *)stringWithMD5OfFile:(NSString *)path;

@end
