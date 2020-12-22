Pod::Spec.new do |s|
  s.name             = 'EachNavigationBar'
  s.version          = '1.15.0'
  s.summary          = 'A custom navigation bar of UIViewController.'
  s.homepage         = 'https://github.com/Pircate/EachNavigationBar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pircate' => 'gao497868860@gmail.com' }
  s.source           = { :git => 'https://github.com/Pircate/EachNavigationBar.git', :tag => s.version.to_s }
  s.source_files     = 'EachNavigationBar/Classes/**/*'
  s.resource_bundles = { 'EachNavigationBar' => ['EachNavigationBar/Assets/*.xcassets'] }
  s.frameworks       = 'UIKit'
  s.swift_versions   = ['4.2', '5.0', '5.1']
  s.ios.deployment_target = '10.0'
end
