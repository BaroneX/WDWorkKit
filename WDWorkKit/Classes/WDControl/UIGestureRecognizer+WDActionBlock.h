//
//  UIGestureRecognizer+ALActionBlocks.h
//  ALActionBlocks
//
//  Created by Andy LaVoy on 10/17/13.
//  Copyright (c) 2013 Andy LaVoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDActionBlockWrapper.h"

@interface UIGestureRecognizer (WDActionBlock)

+ (instancetype)initWithBlock:(WDActionBlock)actionBlock;
- (void)setBlock:(WDActionBlock)actionBlock;

@end
