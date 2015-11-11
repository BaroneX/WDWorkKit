//
//  SDImageViewController.m
//  SDShipper
//
//  Created by Blake on 15/7/23.
//  Copyright (c) 2015年 Blake. All rights reserved.
//

#import "WDImageLoaderController.h"
#import "UIImageView+WebCache.h"
#import "WDFrameWork.h"
#import "HZIndicatorView.h"
@interface WDImageLoaderController ()<UIScrollViewDelegate>
{

    UIImageView *imageView;

}
@property (nonatomic,strong) HZIndicatorView *indicatorView;

@end

@implementation WDImageLoaderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView* scorll = ({
        UIScrollView* scorll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WinSize.width, WinSize.height-64)];
        scorll.maximumZoomScale = 2;
        scorll.minimumZoomScale = 1;
        scorll.delegate = self;
        scorll;
    });
    [self.view addSubview:scorll];
    
    imageView = ({
        UIImageView* tempImageView = [[UIImageView alloc]initWithFrame:scorll.bounds];
        tempImageView.userInteractionEnabled = YES;
        tempImageView.contentMode = UIViewContentModeScaleAspectFit;
        scorll.contentSize = tempImageView.bounds.size;
        tempImageView;
    });

    [scorll addSubview:imageView];
    
    //默认显示图片
    if (_image) {
        imageView.image = _image;
    }else{
    
        if ([FSTRING(_imageURLString) isValid]) {
            [self configureView];
        }
    }
    
    // Do any additional setup after loading the view from its nib.
}
//告诉scrollview要缩放的是哪个子控件
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
 {
     return imageView;
}

- (void)configureView
{

    if (self.imageURLString) {
        __weak UIImageView *weakImageView = imageView;
        
        HZIndicatorView *indicatorView = [[HZIndicatorView alloc] init];
        indicatorView.viewMode = HZIndicatorViewModeLoopDiagram;
        indicatorView.center = CGPointMake(kAPPWidth * 0.5, kAppHeight * 0.5);
        self.indicatorView = indicatorView;
        [self.view addSubview:indicatorView];
        
        __weak __typeof(self)weakSelf = self;
        [imageView sd_setImageWithURL:[NSURL URLWithString:_imageURLString] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            strongSelf.indicatorView.progress = (CGFloat)receivedSize / expectedSize;
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [indicatorView removeFromSuperview];
            weakImageView.image = image;
        }];
    }
}


@end
