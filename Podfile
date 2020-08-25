# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs.git'

target 'ruyiRuyi' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Pods for ruyiRuyi
  pod 'Masonry'
  pod 'AFNetworking'
  pod 'IQKeyboardManager'
  pod 'MJRefresh'
  pod 'SDCycleScrollView'
  pod 'BaiduMapKit' #百度地图SDK
  pod 'MBProgressHUD'
  pod 'ZBarSDK'
  pod 'MJExtension'

   #照片选择
   pod 'TZImagePickerController'

  # 主模块(必须)
  pod 'mob_sharesdk'
 
  # UI模块(非必须，需要用到ShareSDK提供的分享菜单栏和分享编辑页面需要以下1行)
  pod 'mob_sharesdk/ShareSDKUI'
 
  #(微信sdk不带支付的命令）
  # pod 'mob_sharesdk/ShareSDKPlatforms/WeChat'   
  #（微信sdk带支付的命令，和上面不带支付的不能共存，只能选择一个）
  pod 'mob_sharesdk/ShareSDKPlatforms/WeChatFull' 

  #腾讯
  pod 'Bugly'
  
  #极光推送
  pod 'JPush'

  #支付宝支付sdk
  pod 'AlipaySDK-iOS'

  target 'ruyiRuyiTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ruyiRuyiUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
