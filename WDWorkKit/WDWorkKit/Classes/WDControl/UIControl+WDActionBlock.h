//
//  UIControl+WDActionBlock.h
//  tets1
//
//  Created by Blake on 15/11/11.
//  Copyright © 2015年 Blake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDActionBlockWrapper.h"
@interface UIControl (WDActionBlock)


- (void)handleControlEvents:(UIControlEvents)controlEvents withBlock:(WDActionBlock)actionBlock;

- (void)removeActionBlocksForControlEvents:(UIControlEvents)controlEvents;



@end
