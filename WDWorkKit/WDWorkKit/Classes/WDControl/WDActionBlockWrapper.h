//
//  WDActionBlockWrapper.h
//  tets1
//
//  Created by Blake on 15/11/11.
//  Copyright © 2015年 Blake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^WDActionBlock)(id weakSender);

static NSString *const WDActionBlockArray = @"WDActionBlockArray";

@interface WDActionBlockWrapper : NSObject

@property(nonatomic,copy)WDActionBlock actionBlock;

@property (nonatomic, assign) UIControlEvents controlEvents;

- (void)invokeBlock:(id)sender;


@end
