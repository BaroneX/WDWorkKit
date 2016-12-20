//
//  WDCountButton.h
//  WDFrameWork
//
//  Created by Blake on 14/8/7.
//  Copyright (c) 2014年 BLAKE. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WDCountButtonDelegate <NSObject>

-(void)countButtonClicked;

@end
@interface WDCountButton : UIButton

@property(nonatomic,weak)id<WDCountButtonDelegate> delegate;

@property(nonatomic)int countTime;//计时时间

@property(nonatomic,strong)UIImage* nomaelImage;//正常状态的背景

@property(nonatomic,strong)UIImage* countImage;//计时状态的背景

@property(nonatomic,strong)UIColor* nomaelColor;//正常状态的背景颜色

@property(nonatomic,strong)UIColor* countColor;//计时状态的背景颜色

-(void)countDown;


@end
