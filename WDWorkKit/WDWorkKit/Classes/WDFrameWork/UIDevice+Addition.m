//
//  UIDevice+Addition.m
//  MSZXFramework
//
//  Created by wenyanjie on 14-11-21.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "UIDevice+Addition.h"
#import <AdSupport/AdSupport.h>
#import "WDSystemInfo.h"
@implementation UIDevice (Addition)

- (NSString *)deviceIdentifier
{
    
//    return @"F63FF6B4-AE44-4805-81F3-E1AAEAE15E9C";
    
    NSString *identify =nil;
//    if (IOS6_OR_LATER)
//    {
//        KeychainItemWrapper * keychin                                                          = [[KeychainItemWrapper alloc]initWithIdentifier:@"SDIDFV" accessGroup:nil];
//        NSString *idfv                                                                         = [keychin objectForKey:(__bridge id)kSecValueData];
//        NSLog(@"%@",idfv);
//        if (idfv.length == 0) {
//            idfv                                                                                   = [[[UIDevice currentDevice]identifierForVendor]UUIDString];
//            
//            [keychin setObject:idfv forKey:(__bridge id)kSecValueData];
//        }w//        NSLog(@"%@",idfv);
//        return idfv;
//        
////        identify= [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//    }
//    else
//    {
        identify = [[[UIDevice currentDevice]identifierForVendor]UUIDString];
//    }
    
    return identify;
}

@end
