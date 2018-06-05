
Pod::Spec.new do |s|
    
  s.name             = 'EachNavigationBar'
  s.version          = '0.2.0'
  s.summary          = 'A custom navigation bar of UIViewController.'
  s.homepage         = 'https://github.com/Pircate/EachNavigationBar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gaoX' => 'gao497868860@163.com' }
  s.source           = { :git => 'https://github.com/Pircate/EachNavigationBar.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'EachNavigationBar/Classes/**/*'
  s.frameworks = 'UIKit'
  s.swift_version = '4.0'
  
end
