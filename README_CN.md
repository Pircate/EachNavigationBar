# EachNavigationBar

[![Lint](https://github.com/Pircate/EachNavigationBar/workflows/Lint/badge.svg)](https://github.com/Pircate/EachNavigationBar/actions?query=workflow%3ALint)
[![Version](https://img.shields.io/cocoapods/v/EachNavigationBar.svg?style=flat)](http://cocoapods.org/pods/EachNavigationBar)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/EachNavigationBar.svg?style=flat)](http://cocoapods.org/pods/EachNavigationBar)
[![Platform](https://img.shields.io/cocoapods/p/EachNavigationBar.svg?style=flat)](https://cocoapods.org/pods/EachNavigationBar)

## 示例

要运行示例项目，首先克隆 repo 并在 Example 目录运行 `pod install`。

## 版本要求

* iOS 9.0
* Swift 4.2

## 安装

EachNavigationBar 可通过 [CocoaPods](http://cocoapods.org) 或者 [Carthage](https://github.com/Carthage/Carthage) 安装, 简单的添加下面一行到你的 Podfile 或者 Cartfile:

### Podfile

```ruby
pod 'EachNavigationBar'
```

### Cartfile
```ruby
github "Pircate/EachNavigationBar"
```

## 预览

![](https://github.com/Pircate/EachNavigationBar/blob/master/demo_new.gif)
![](https://github.com/Pircate/EachNavigationBar/blob/master/demo_push.gif)

## 用法

### 导入

Swift
``` swift
import EachNavigationBar
```

### 开启

给当前导航栈的 viewControllers 添加一个独立的导航栏。

只对当前导航栈有效，不影响其他导航栈。

``` swift
let nav = UINavigationController(rootViewController: vc)
nav.navigation.configuration.isEnabled = true
```

###  设置
#### 导航栈全局配置

不要通过 navigationController.navigationBar 去设置全局属性!!!

更多配置请看[这里](https://github.com/Pircate/EachNavigationBar/blob/master/EachNavigationBar/Classes/Configuration.swift)

``` swift
nav.navigation.configuration.titleTextAttributes = [.foregroundColor: UIColor.blue]

nav.navigation.configuration.barTintColor = UIColor.red

nav.navigation.configuration.shadowImage = UIImage(named: "shadow")

nav.navigation.configuration.setBackgroundImage(UIImage(named: "nav"), for: .any, barMetrics: .default)

nav.navigation.configuration.backItem = UINavigationController.Configuration.BackItem(style: .title("返回"))

nav.navigation.configuration.prefersLargeTitles = true

nav.navigation.configuration.largeTitle.displayMode = .always
```

#### 每个控制器设置
##### 普通设置

``` swift
// 一般用法同系统组件
navigation.bar  -> EachNavigationBar -> UINavigationBar
navigation.item -> UINavigationItem

// 隐藏导航栏
navigation.bar.isHidden = true

// 设置导航栏透明度
navigation.bar.alpha = 0.5

// 设置标题透明度
navigation.bar.setTitleAlpha(0.5)

// 设置 barButtonItem 透明度
navigation.bar.setTintAlpha(0.5)
// 如果 barButtonItem 是自定义视图
navigation.item.leftBarButtonItem?.customView?.alpha = 0.5
// 如果 barButtonItem 自定义了 tintColor
navigation.item.leftBarButtonItem?.tintColor = navigation.item.leftBarButtonItem?.tintColor?.withAlphaComponent(0.5)

// 移除毛玻璃效果
navigation.bar.isTranslucent = false

// 隐藏底部阴影
navigation.bar.isShadowHidden = true

// 设置状态栏样式
navigation.bar.statusBarStyle = .lightContent

// 设置返回按钮
navigation.bar.backBarButtonItem = .init(style: .title("Back"), tintColor: .red)

// 允许返回事件
navigation.bar.backBarButtonItem.shouldBack = { item in
    // do something
    return false
}

// 返回事件之前回调
navigation.bar.backBarButtonItem.willBack = {
    // do something
}

// 返回事件之后回调
navigation.bar.backBarButtonItem.didBack = {
    // do something
}

// 如果想自定义导航栏位置，请将下面属性设为 false
navigation.bar.automaticallyAdjustsPosition = false

// 导航栏附加高度
navigation.bar.additionalHeight = 14

// 导航栏附加视图
navigation.bar.additionalView = UIView()

// 导航栏阴影
navigation.bar.shadow = Shadow(
    color: UIColor.black.cgColor,
    opacity: 0.5,
    offset: CGSize(width: 0, height: 3))
```

##### 大标题设置(iOS 11.0+)

``` swift
// 开启大标题
navigation.bar.prefersLargeTitles = true

// 显示模式
navigation.item.largeTitleDisplayMode = .always

// 设置大标题透明度
navigation.bar.setLargeTitleAlpha(0.5)
```

#### 关于约束

    和使用系统导航栏完全一致。

* 请注意 iOS 11 以上和以下的区别。
* 如果使用 XIB 请参看[这篇文章](https://www.jianshu.com/p/ba9bb519f07f)，应该会有帮助。
* [SnapKit](https://github.com/SnapKit/SnapKit) 用户可以试试这个 [extension](https://gist.github.com/Pircate/52a3aeb2c59695f6e997a6f3bd19242b)。

## 作者

Pircate, gao497868860@163.com

## 许可证

EachNavigationBar 可在 MIT 许可证下使用。有关更多信息，请参阅许可证文件。
