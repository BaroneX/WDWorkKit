//
//  UIImage+Addition.h
//  WDFrameWork
//
//  Created by Blake on 15/3/24.
//  Copyright (c) 2015年 Blake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (Addition)
/**
 *  根据颜色获取图片
 *
 *  @param color 颜色
 *  @param size  大小
 *
 *  @return 颜色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  改变image大小(会失真)
 *
 *  @param image     需要改变的image
 *  @param scaleSize 缩放比例
 *
 *  @return 返回处理后的图片
 */
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

/**
 *  改变image大小(会失真)
 *
 *  @param image  需要改变的image
 *  @param reSize 改变的大小
 *
 *  @return 返回处理后的图片
 */
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

/**
 *  截图
 *
 *  @param view 需要截图的view
 *
 *  @return 返回处理后的图片
 */
+(UIImage*)getImageFromView:(UIView*)view;

@end
