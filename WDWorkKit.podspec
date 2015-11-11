#
# Be sure to run `pod lib lint WDWorkKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "WDWorkKit"
  s.version          = "1.0.0"
  s.summary          = "A short description of WDWorkKit."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = "WDWorkKit "

  s.homepage         = "https://github.com/BaroneX/WDWorkKit"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Blake" => "271231406@qq.com" }
  s.source           = { :git => "https://github.com/BaroneX/WDWorkKit.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'WDWorkKit/Classes/**/*'
  s.resource_bundles = {
    'WDWorkKit' => ['WDWorkKit/Assets/*.png']
  }
  
  # s.public_header_files = 'WDWorkKit/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking'
  s.dependency 'SDWebImage'
  s.dependency 'MBProgressHUD'
  s.dependency 'TTTAttributedLabel'
  s.dependency 'MJRefresh'
  s.dependency 'MJExtension'
  s.dependency 'LKDBHelper'
  s.dependency 'SVProgressHUD'
  s.dependency 'DateTools'
  s.dependency 'IQKeyboardManager'
  s.dependency 'Masonry'

end
