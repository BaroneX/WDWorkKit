//
//  WDUIConfigDefine.h
//  WDFrameWork
//
//  Created by Blake on 15/3/16.
//  Copyright (c) 2015年 Blake. All rights reserved.
//

#ifndef WDFrameWork_WDUIConfigDefine_h
#define WDFrameWork_WDUIConfigDefine_h

//获取非空值
#define EffectiveValue(x) (x == nil)?@"null":x
#define EffectiveNumber(x) (x == nil)?@"":x
#define ValuedNumber(x) (x == nil)?@"0":x

//16进制颜色
#define UIColorFromHexValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBAValue(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]



#endif
