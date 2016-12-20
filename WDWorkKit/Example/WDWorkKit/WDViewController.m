//
//  WDViewController.m
//  WDWorkKit
//
//  Created by Blake on 11/05/2015.
//  Copyright (c) 2015 Blake. All rights reserved.
//

#import "WDViewController.h"
#import <WDWorkKit.h>
@interface WDViewController ()
{
    __weak IBOutlet UIButton *button;

}
@end

@implementation WDViewController

- (void)viewDidLoad
{
    
    
#if  __has_include(<WDWorkKit.h>)
    NSLog(@"wdworkkit");
#else
    NSLog(@"null");
#endif
    
    [super viewDidLoad];
    
    [button handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        
        NSLog(@"clicked");
        
        
    }];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
