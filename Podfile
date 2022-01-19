# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'GXLCodeRepository' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Pods for GXLCodeRepository
  pod 'SVProgressHUD'
  pod 'SDWebImage'
  pod 'Masonry'
  pod 'AFNetworking'
  pod 'MJExtension'
  pod 'MJRefresh'
  pod 'FLEX', :configurations => ['Debug']
  
  
  pod "BCEventBus",:subspecs => ["Core", "ServiceLoader"], :tag => "1.0.1", :git => "git@gitlab.leke.cn:health-huihui/app/ios/ios-component/BCEventBus.git"
  
  

  # 基础组件
  pod "BCComConfigKit", :tag => "1.0.1", :subspecs => ["Core"], :git => "git@gitlab.leke.cn:health-huihui/app/ios/ios-component/BCComConfigKit.git"

  # Foundation基础库
  pod "BCFoundation", :tag => "1.0.2", :subspecs => ["Core", "AttributedString", "Device", "Utils"], :git => "git@gitlab.leke.cn:health-huihui/app/ios/ios-component/BCFoundation.git"

  # 日志组件
  pod "BCFileLog", :tag => "1.0.0", :subspecs => ["Core"], :git => "git@gitlab.leke.cn:health-huihui/app/ios/ios-component/BCFileLog.git"

  # 基础UI扩展
  pod "BCUIKit", :tag => "1.0.0", :subspecs => ["Core", "Input",  "ScrollView", "Label"], :git => "git@gitlab.leke.cn:health-huihui/app/ios/ios-component/BCUIKit.git", :inhibit_warnings => false, :branch => "master"

end
