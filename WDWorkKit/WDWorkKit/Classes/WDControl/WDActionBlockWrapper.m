//
//  WDActionBlockWrapper.m
//  tets1
//
//  Created by Blake on 15/11/11.
//  Copyright © 2015年 Blake. All rights reserved.
//

#import "WDActionBlockWrapper.h"

@implementation WDActionBlockWrapper


-(void)invokeBlock:(id)sender{
    if (self.actionBlock) {
        self.actionBlock(sender);
    }
}

@end
