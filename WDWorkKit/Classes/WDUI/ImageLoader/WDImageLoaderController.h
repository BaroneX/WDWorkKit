//
//  SDImageViewController.h
//  SDShipper
//
//  Created by Blake on 15/7/23.
//  Copyright (c) 2015年 Blake. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  图片预览
 */
@interface WDImageLoaderController : UIViewController

/**
 *  图片URL
 */
@property (copy, nonatomic)NSString * imageURLString;
/**
 *  预览图(默认显示预览图 无预览图 显示url)
 */
@property(nonatomic,strong)UIImage* image;

@end
