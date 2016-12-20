# WDWorkKit

[![CI Status](http://img.shields.io/travis/Blake/WDWorkKit.svg?style=flat)](https://travis-ci.org/Blake/WDWorkKit)
[![Version](https://img.shields.io/cocoapods/v/WDWorkKit.svg?style=flat)](http://cocoapods.org/pods/WDWorkKit)
[![License](https://img.shields.io/cocoapods/l/WDWorkKit.svg?style=flat)](http://cocoapods.org/pods/WDWorkKit)
[![Platform](https://img.shields.io/cocoapods/p/WDWorkKit.svg?style=flat)](http://cocoapods.org/pods/WDWorkKit)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

WDWorkKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
source 'https://github.com/BaroneX/WDSpecs.git' #添加私有pod仓库地址

pod "WDWorkKit"
```
WDWorkKit Tree 
	
		WDWorkKit
		├── Assets	#资源文件
		│   ├── b27_icon_star_gray@2x.png
		│   ├── b27_icon_star_yellow@2x.png
		│   ├── radio_checked.png
		│   └── radio_unchecked.png
		└── Classes
		    ├── WDFrameWork #常用
		    │   ├── NSDate+WDCalendar.h
		    │   ├── NSDate+WDCalendar.m
		    │   ├── NSString+Addition.h
		    │   ├── NSString+Addition.m
		    │   ├── NSString+PJR.h
		    │   ├── NSString+PJR.m
		    │   ├── Reachability.h
		    │   ├── Reachability.m
		    │   ├── UIDevice+Addition.h
		    │   ├── UIDevice+Addition.m
		    │   ├── UIImage+Addition.h
		    │   ├── UIImage+Addition.m
		    │   ├── WDCoreAnimationEffect.h
		    │   ├── WDCoreAnimationEffect.m
		    │   ├── WDCountButton.h
		    │   ├── WDCountButton.m
		    │   ├── WDCycleScrollView.h
		    │   ├── WDCycleScrollView.m
		    │   ├── WDFrameWork.h
		    │   ├── WDJsonKit.h
		    │   ├── WDJsonKit.m
		    │   ├── WDReachability.h
		    │   ├── WDReachability.m
		    │   ├── WDSandbox.h
		    │   ├── WDSandbox.m
		    │   ├── WDSystemInfo.h
		    │   ├── WDSystemInfo.m
		    │   ├── WDUIConfigDefine.h
		    │   ├── WDViewExt.h
		    │   ├── WDViewExt.m
		    │   └── WDWorkKit.h
		    ├── WDNetWork #网络
		    │   ├── WDNetWork.h
		    │   └── WDNetWork.m
		    └── WDUI #UI部分
		        ├── CWStarRateView
		        │   ├── CWStarRateView.h
		        │   └── CWStarRateView.m
		        ├── DOPDropDownMenu.h
		        ├── DOPDropDownMenu.m
		        ├── JKAlertDialog
		        │   ├── JKAlertDialog.h
		        │   └── JKAlertDialog.m
		        ├── MPNotificationView
		        │   ├── MPNotificationView.h
		        │   ├── MPNotificationView.m
		        │   ├── OBGradientView.h
		        │   └── OBGradientView.m
		        ├── PopoverView.h
		        ├── PopoverView.m
		        ├── QRadioButton
		        │   ├── QRadioButton.h
		        │   └── QRadioButton.m
		        ├── UIView+Toast.h
		        └── UIView+Toast.m
		



```
WDPayKit/ 
├── WDPayConfig.h 	//配置文件
├── WDPayKit.h    	//支付接口
├── WDPayKit.mm   
├── WDPayResult.h 	//交易结果类
├── WDPayResult.m
│   
├── ALPay  			//支付宝
│   ├── AlipaySDK.bundle
│   ├── AlipaySDK.framework
│   ├── WDALPayAdapter.h 
│   └── WDALPayAdapter.m
│   
├── UPPAY 			 //银联
│   ├── UPPayPlugin.h
│   ├── UPPayPluginDelegate.h
│   ├── WDUNPayAdapter.h
│   ├── WDUNPayAdapter.m
│   └── libUPPayPlugin.a
│   
└── WXPay  			//微信
    ├── WDWXPayAdapter.h
    ├── WDWXPayAdapter.m
    ├── WXApi.h
    ├── WXApiObject.h
    ├── libWeChatSDK.a
    └── read_me.txt
```

## Author

Blake, 271231406@qq.com

## License

WDWorkKit is available under the MIT license. See the LICENSE file for more info.

>>>>>>> 8d7b854dcc15f3eab959e56cd6a6c0d742df0a60
