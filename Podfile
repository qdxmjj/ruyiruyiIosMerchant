# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

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
  pod 'Harpy' #提示更新
  # 主模块(必须)
  pod 'mob_sharesdk'
 
  # UI模块(非必须，需要用到ShareSDK提供的分享菜单栏和分享编辑页面需要以下1行)
  pod 'mob_sharesdk/ShareSDKUI'
 
  # 平台SDK模块(对照一下平台，需要的加上。如果只需要QQ、微信、新浪微博，只需要以下3行)
  pod 'mob_sharesdk/ShareSDKPlatforms/WeChat'

  target 'ruyiRuyiTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ruyiRuyiUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
