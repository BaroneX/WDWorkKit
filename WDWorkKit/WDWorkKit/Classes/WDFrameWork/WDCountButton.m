//
//  WDCountButton.m
//  WDFrameWork
//
//  Created by Blake on 14/8/7.
//  Copyright (c) 2014年 BLAKE. All rights reserved.
//

#import "WDCountButton.h"

@implementation WDCountButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initButton];
          }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initButton];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initButton];
    }
    return self;
}
-(void)initButton{

    self.titleLabel.adjustsFontSizeToFitWidth = YES;
//    [self setTitle:@"发送验证码" forState:UIControlStateNormal];
    [self addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];

}
-(void)setNomaelImage:(UIImage *)nomaelImage{

    _nomaelImage = nomaelImage;
     [self setBackgroundImage:nomaelImage forState:UIControlStateNormal];

}
-(void)setNomaelColor:(UIColor *)nomaelColor{
    
    _nomaelColor = nomaelColor;
    self.backgroundColor = nomaelColor;

}
-(void)clicked{
//    [self countDown];

    [self.delegate countButtonClicked];
}
-(void)countDown{
    
    __block int timeout=self.countTime; //倒计时时间
    if (self.countImage) {
        [self setBackgroundImage:self.countImage forState:UIControlStateNormal];
    }else if (self.countColor){
        self.backgroundColor = self.countColor;
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
                if (self.nomaelImage) {
                    [self setBackgroundImage:self.nomaelImage forState:UIControlStateNormal];
                }else if (self.nomaelColor){
                    self.backgroundColor = self.nomaelColor;
                }
                
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 600;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置

                [self setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
