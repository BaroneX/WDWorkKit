//
//  NSString+Addition.h
//  MSZXFramework
//
//  Created by wenyanjie on 14-12-17.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Addition)

#define FSTRING(X) [NSString stringWithFormat:@"%@",X]
#define APPENDSTRING(a,b) [(FSTRING(a)) stringByAppendingFormat:@"%@",b]
#define INTSTRING(x) [NSString stringWithFormat:@"%d",x]
#define INTEGERSTRING(x) [NSString stringWithFormat:@"%ld",x]


#pragma mark - 字符串处理
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
 *  字符是否有效
 *
 *  @return 是否有效
 */
-(BOOL)isValid;

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

#pragma mark - 字符串处理

/**
 *  算字符个数
 *
 *  @return 字符个数
 */
- (NSUInteger)countNumberOfWords;

/**
 *  是否包含字符
 *
 *  @param subString 包含的字符
 *
 *  @return Yes or No
 */
- (BOOL)containsString:(NSString *)subString;

/**
 *  是否以字符开头
 *
 *  @param string 开头字符
 *
 *  @return Yes or No
 */
- (BOOL)isBeginsWith:(NSString *)string;

/**
 *  是否以字符结尾
 *
 *  @param string  结尾字符
 *
 *  @return  Yes or No
 */
- (BOOL)isEndssWith:(NSString *)string;

/**
 *  替换字符
 *
 *  @param olderChar 需要替换的字符
 *  @param newerChar 替换字符
 *
 *  @return 替换后字符
 */
- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar;

/**
 *  截取字符
 *
 *  @param begin 开始位置
 *  @param end   结束位置
 *
 *  @return 截取后的字符
 */
- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end;

/**
 *  删除字符
 *
 *  @param subString 需要删除的字符
 *
 *  @return 删除后的字符
 */
- (NSString *)removeSubString:(NSString *)subString;

/**
 *  是否只包含字母
 *
 *  @return Yes or No
 */
- (BOOL)containsOnlyLetters;

/**
 *  是否只包含数字
 *
 *  @return Yes or No
 */
- (BOOL)containsOnlyNumbers;

/**
 *  是否只包含字母和数字
 *
 *  @return Yes or No
 */
- (BOOL)containsOnlyNumbersAndLetters;

/**
 *  从数组获取字符 拼接@" "
 *
 *  @param array 字符数组
 *
 *  @return 拼接后的字符
 */
+ (NSString *)getStringFromArray:(NSArray *)array;

/**
 *  把字符转换为数组 以separateString分割
 *
 *  @param separateString 分割字符
 *
 *  @return 分割后的数组
 */
- (NSArray *)getArrayWithSeparateString:(NSString*)separateString;

/**
 *  转换为data utf-8
 *
 *  @return 字符data
 */
- (NSData *)convertToData;

/**
 *  data转字符 utf-8
 *
 *  @param data data
 *
 *  @return 字符
 */
+ (NSString *)getStringFromData:(NSData *)data;


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
