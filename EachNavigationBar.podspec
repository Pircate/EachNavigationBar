Pod::Spec.new do |s|
  s.name             = 'EachNavigationBar'
  s.version          = '1.8.2'
  s.summary          = 'A custom navigation bar of UIViewController.'
  s.homepage         = 'https://github.com/Pircate/EachNavigationBar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gaoX' => 'gao497868860@163.com' }
  s.source           = { :git => 'https://github.com/Pircate/EachNavigationBar.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'
  s.source_files = 'EachNavigationBar/Classes/**/*'
  s.resource_bundles = {
    'EachNavigationBar' => ['EachNavigationBar/Assets/*.xcassets']
  }
  s.frameworks = 'UIKit'
end
