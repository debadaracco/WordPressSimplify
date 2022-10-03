#
# Be sure to run `pod lib lint WordPressSimplify.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WordPressSimplify'
  s.version          = '0.1.0'
  s.summary          = "Simplify WordPress requests and models"

  s.homepage         = 'https://github.com/debadaracco/WordPressSimplify'
  s.license          = { :type => 'GPL-3.0', :file => 'LICENSE' }
  s.author           = { 'Diego Badaracco' => 'debadaracco@gmail.com' }
  s.source           = { :git => 'https://github.com/debadaracco/WordPressSimplify.git', :tag => s.version.to_s }
  s.social_media_url = "https://twitter.com/debadaracco"

  s.ios.deployment_target = '10.0'

  s.source_files = 'Source/Classes/**/*'
  s.swift_versions = ['5']
end
