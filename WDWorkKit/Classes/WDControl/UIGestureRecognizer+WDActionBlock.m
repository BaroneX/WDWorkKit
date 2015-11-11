//
//  UIGestureRecognizer+ALActionBlocks.m
//  ALActionBlocks
//
//  Created by Andy LaVoy on 10/17/13.
//  Copyright (c) 2013 Andy LaVoy. All rights reserved.
//

#import "UIGestureRecognizer+WDActionBlock.h"
#import "WDActionBlockWrapper.h"
#import <objc/runtime.h>

@implementation UIGestureRecognizer (ALActionBlocks)


+ (instancetype)initWithBlock:(WDActionBlock)actionBlock {
    UIGestureRecognizer *gestureRecognizer = [[[self class] alloc] init];
    [gestureRecognizer setBlock:actionBlock];
    return gestureRecognizer;
}


- (void)setBlock:(WDActionBlock)actionBlock {
    NSMutableArray *actionBlocksArray = [self actionBlocksArray];
    
    WDActionBlockWrapper *blockActionWrapper = [[WDActionBlockWrapper alloc] init];
    blockActionWrapper.actionBlock = actionBlock;
    [actionBlocksArray addObject:blockActionWrapper];
    
    [self addTarget:blockActionWrapper action:@selector(invokeBlock:)];
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
