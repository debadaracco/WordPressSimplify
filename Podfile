use_frameworks!

platform :ios, '11.0'

workspace 'WordPressSimplify'
project 'WordPressSimplify.xcodeproj'

target 'WordPressSimplify_Example' do
  pod 'WordPressSimplify', :path => './'
  pod "UIScrollView-InfiniteScroll"
  
  target 'WordPressSimplify_Tests' do
    inherit! :search_paths

    
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end
