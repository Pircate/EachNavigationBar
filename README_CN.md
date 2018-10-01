# EachNavigationBar

[![CI Status](http://img.shields.io/travis/Pircate/EachNavigationBar.svg?style=flat)](https://travis-ci.org/Pircate/EachNavigationBar)
[![Version](https://img.shields.io/cocoapods/v/EachNavigationBar.svg?style=flat)](http://cocoapods.org/pods/EachNavigationBar)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/EachNavigationBar.svg?style=flat)](http://cocoapods.org/pods/EachNavigationBar)
![iOS 8.0+](https://img.shields.io/badge/iOS-8.0%2B-blue.svg)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 8.0+
* Swift 4

## Installation

EachNavigationBar is available through [CocoaPods](http://cocoapods.org) or [Carthage](https://github.com/Carthage/Carthage). To install
it, simply add the following line to your Podfile or Cartfile:

### CocoaPods

```ruby
pod 'EachNavigationBar'
```

### Carthage
```ruby
github "Pircate/EachNavigationBar"
```

## Overview

![](https://github.com/Pircate/EachNavigationBar/blob/master/demo.gif)

## 用法

### 导入

``` swift
import EachNavigationBar
```

### 安装(千万别忘了)

``` swift
// 在设置 rootViewController 之前
UIViewController.setupNavigationBar
```

### 开启导航控制器每个子控制器的独立导航栏

``` swift
let nav = UINavigationController(rootViewController: vc)
nav.navigation.configuration.isEnabled = true
```

###  设置
#### 导航栈全局配置

``` swift
let nav = UINavigationController(rootViewController: vc)
// 设置标题属性
nav.navigation.configuration.titleTextAttributes = [.foregroundColor: UIColor.blue]
// 设置导航栏背景色
nav.navigation.configuration.barTintColor = UIColor.red
// 设置导航栏背景图片
nav.navigation.configuration.backgroundImage = UIImage(named: "nav")
// 设置导航栏阴影图片
nav.navigation.configuration.shadowImage = UIImage(named: "shadow")
// 设置返回按钮图片
nav.navigation.configuration.backImage = UIImage(named: "back")
```

#### 每个控制器设置
##### 基础设置

``` swift
// 一般用法同系统组件
navigation.bar  -> EachNavigationBar -> UINavigationBar
navigation.item -> UINavigationItem

// 隐藏导航栏
navigation.bar.isHidden = true

// 设置透明度
navigation.bar.alpha = 0.5

// 移除毛玻璃效果
navigation.bar.isTranslucent = false

// 隐藏底部黑线
navigation.bar.shadowImage = UIImage()
// 如果 iOS 版本小于11.0，还需要
navigation.bar.setBackgroundImage(UIImage(), for: .default)

// 如果你想设置状态栏白色文字
navigationController?.navigationBar.barStyle = .black

// 如果你想改变导航栏位置
navigation.bar.isUnrestoredWhenViewWillLayoutSubviews = true

// 自定义返回按钮事件
navigation.item.leftBarButtonItem?.action = #selector(backBarButtonAction)
```

##### 大标题设置(iOS 11.0+)

###### 全局导航栈开启大标题
``` swift
if #available(iOS 11.0, *) {
    navigationController?.navigationBar.prefersLargeTitles = true
}
```
###### 每个控制器显示和隐藏大标题
```swift
// 显示大标题
if #available(iOS 11.0, *) {
    navigationItem.largeTitleDisplayMode = .always
}
// 隐藏大标题
if #available(iOS 11.0, *) {
    navigationItem.largeTitleDisplayMode = .never
}
```

### For Objective-C
[AYNavigationBar](https://github.com/Pircate/AYNavigationBar)

## Author

Pircate, gao497868860@163.com

## License

EachNavigationBar is available under the MIT license. See the LICENSE file for more info.
