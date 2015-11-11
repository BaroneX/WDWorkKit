//
//  UIControl+WDActionBlock.m
//  tets1
//
//  Created by Blake on 15/11/11.
//  Copyright © 2015年 Blake. All rights reserved.
//

#import "UIControl+WDActionBlock.h"
#import <objc/runtime.h>

@implementation UIControl (WDActionBlock)

- (void)handleControlEvents:(UIControlEvents)controlEvents withBlock:(WDActionBlock)actionBlock{
    NSMutableArray* actionBlocksArray = [self actionBlocksArray];
    
    WDActionBlockWrapper* blockWrapper = [WDActionBlockWrapper new];
    blockWrapper.actionBlock = actionBlock;
    blockWrapper.controlEvents = controlEvents;
    [actionBlocksArray addObject:blockWrapper];
    
    
    [self addTarget:blockWrapper action:@selector(invokeBlock:) forControlEvents:controlEvents];
    
}

- (void)removeActionBlocksForControlEvents:(UIControlEvents)controlEvents{
    NSMutableArray* actionBlocksArray = [self actionBlocksArray];

    NSMutableArray *wrappersToRemove = [NSMutableArray arrayWithCapacity:[actionBlocksArray count]];
    
    [actionBlocksArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        WDActionBlockWrapper *wrapperTmp = obj;
        if (wrapperTmp.controlEvents == controlEvents) {
            [wrappersToRemove addObject:wrapperTmp];
            [self removeTarget:wrapperTmp action:@selector(invokeBlock:) forControlEvents:controlEvents];
        }
    }];
    
    [actionBlocksArray removeObjectsInArray:wrappersToRemove];
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
