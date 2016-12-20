//
//  UIBarButtonItem+ALActionBlocks.m
//  ALActionBlocks
//
//  Created by Andy LaVoy on 5/16/13.
//  Copyright (c) 2013 Andy LaVoy. All rights reserved.
//

#import "UIBarButtonItem+WDActionBlock.h"
#import "WDActionBlockWrapper.h"
#import <objc/runtime.h>


@implementation UIBarButtonItem (WDActionBlock)


+ (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem block:(WDActionBlock)actionBlock {
    UIBarButtonItem *barButtonItem = [[[self class] alloc] initWithBarButtonSystemItem:systemItem target:nil action:nil];
    [barButtonItem setBlock:actionBlock];
    return barButtonItem;
}


+ (instancetype)initWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style block:(WDActionBlock)actionBlock {
    UIBarButtonItem *barButtonItem = [[[self class] alloc] initWithImage:image landscapeImagePhone:landscapeImagePhone style:style target:nil action:nil];
    [barButtonItem setBlock:actionBlock];
    return barButtonItem;
}


+ (instancetype)initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style block:(WDActionBlock)actionBlock {
    UIBarButtonItem *barButtonItem = [[[self class] alloc] initWithImage:image style:style target:nil action:nil];
    [barButtonItem setBlock:actionBlock];
    return barButtonItem;
}


+ (instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style block:(WDActionBlock)actionBlock {
    UIBarButtonItem *barButtonItem = [[[self class] alloc] initWithTitle:title style:style target:nil action:nil];
    [barButtonItem setBlock:actionBlock];
    return barButtonItem;
}


- (void)setBlock:(WDActionBlock)actionBlock {
    NSMutableArray *actionBlocksArray = [self actionBlocksArray];
    
    WDActionBlockWrapper *blockActionWrapper = [[WDActionBlockWrapper alloc] init];
    blockActionWrapper.actionBlock = actionBlock;
    [actionBlocksArray addObject:blockActionWrapper];
    
    [self setTarget:blockActionWrapper];
    [self setAction:@selector(invokeBlock:)];
}


- (NSMutableArray *)actionBlocksArray {
    NSMutableArray *actionBlocksArray = objc_getAssociatedObject(self, &WDActionBlockArray);
    if (!actionBlocksArray) {
        actionBlocksArray = [NSMutableArray array];
        objc_setAssociatedObject(self, &WDActionBlockArray, actionBlocksArray, OBJC_ASSOCIATION_RETAIN);
    }
    return actionBlocksArray;
}

@end
