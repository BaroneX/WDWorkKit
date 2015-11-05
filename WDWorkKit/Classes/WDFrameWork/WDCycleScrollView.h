//
//  MSZXCycleScrollView.h
//  MSZXFramework
//
//  Created by wenyanjie on 15-1-29.
//  Copyright (c) 2015年 wenyanjie. All rights reserved.
//

#define PageControllBottomMarign 50

#import <UIKit/UIKit.h>
/**
 *  滚动方向
 */
typedef NS_ENUM(NSInteger, kWDScrollDirection){
    /**
     *  上下滚动
     */
    WDScrollDirectionUp,
    /**
     *  左右滚动
     */
    WDScrollDirectionRight,
};

@class WDCycleScrollView;
@protocol WDCycleScrollViewDelegate <NSObject>

@optional

/**
 *  CycleScrollView滚动时触发的方法
 *
 *  @param currentPage  当前显示的页数
 *  @param adScrollView adScrollView description
 */
- (void)adScrollViewDidScrollWithCurrentPage:(NSInteger)currentPage adScrollView:(WDCycleScrollView *)adScrollView;

/**
 *  点击页面时触发的方法
 *
 *  @param adScrollView adScrollView description
 *  @param contentView  点击的view
 *  @param index        点击view的索引值
 */
- (void)adScrollView:(WDCycleScrollView *)adScrollView tapContentView:(UIView *)contentView viewIndex:(NSInteger)index;

@end

@interface WDCycleScrollView : UIView <UIScrollViewDelegate>


/**
 *  要显示的view数组
 */
@property (nonatomic,strong) NSArray *displayViews;

/**
 *  是否需要循环 default NO
 */
@property(nonatomic)BOOL needCycle;
/**
 *  内容是否需要自动滚动
 */
@property (nonatomic) BOOL autoScroll;

/**
 *  自动滚动的时间间隔
 */
@property (nonatomic) NSTimeInterval autoScrollInterval;


/**
 *  pagecontrol是否隐藏 默认初始化创建pageControl Default NO
 */
@property (nonatomic) BOOL pageControlHidden;

/**
 *  获取pageControl以便修改颜色
 */
@property (nonatomic,strong)UIPageControl * pageControl;


/**
 *  WDCycleScrollViewDelegate代理
 */
@property (nonatomic,weak) id<WDCycleScrollViewDelegate> delegate;

/**
 *  Description
 *
 *  @param frame     frame description
 *  @param array     显示的view数组
 *  @param direction 滚动方向
 *
 *  @return return value description
 */
- (id)initWithFrame:(CGRect)frame contentArray:(NSArray *)array scrollDirection:(kWDScrollDirection)direction;

/**
 *  暂停滚动
 */
- (void)pauseScroll;

/**
 *  继续滚动
 */
- (void)continueScroll;

@end
