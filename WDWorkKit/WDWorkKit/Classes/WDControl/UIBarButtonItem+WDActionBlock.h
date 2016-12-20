//
//  UIBarButtonItem+ALActionBlocks.h
//  ALActionBlocks
//
//  Created by Andy LaVoy on 5/16/13.
//  Copyright (c) 2013 Andy LaVoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIControl+WDActionBlock.h"


@interface UIBarButtonItem (WDActionBlock)

+ (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem block:(WDActionBlock)actionBlock;
+ (instancetype)initWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style block:(WDActionBlock)actionBlock;
+ (instancetype)initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style block:(WDActionBlock)actionBlock;
+ (instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style block:(WDActionBlock)actionBlock;

- (void)setBlock:(WDActionBlock)actionBlock;

@end
