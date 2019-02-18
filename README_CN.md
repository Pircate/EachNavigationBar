# EachNavigationBar

[![CI Status](http://img.shields.io/travis/Pircate/EachNavigationBar.svg?style=flat)](https://travis-ci.org/Pircate/EachNavigationBar)
[![Version](https://img.shields.io/cocoapods/v/EachNavigationBar.svg?style=flat)](http://cocoapods.org/pods/EachNavigationBar)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/EachNavigationBar.svg?style=flat)](http://cocoapods.org/pods/EachNavigationBar)
![iOS 9.0+](https://img.shields.io/badge/iOS-9.0%2B-blue.svg)

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
Objective-C
``` ObjC
@import EachNavigationBar;
```

### 开启

给当前导航栈的 viewControllers 添加一个独立的导航栏。

只对当前导航栈有效，不影响其他导航栈。

Swift
``` swift
let nav = UINavigationController(rootViewController: vc)
nav.navigation.configuration.isEnabled = true
```

Objective-C
``` ObjC
UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
nav.navigation_configuration.isEnabled = YES;
```

###  设置
#### 导航栈全局配置

更多配置请看[这里](https://github.com/Pircate/EachNavigationBar/blob/master/EachNavigationBar/Classes/UINavigationController%2BConfiguration.swift)

Swift
``` swift
nav.navigation.configuration.titleTextAttributes = [.foregroundColor: UIColor.blue]

nav.navigation.configuration.barTintColor = UIColor.red

nav.navigation.configuration.shadowImage = UIImage(named: "shadow")

nav.navigation.configuration.backBarButtonItem = .init(style: .image(UIImage(named: "back")), tintColor: UIColor.red)

nav.navigation.configuration.setBackgroundImage(UIImage(named: "nav"), for: .any, barMetrics: .default)
```

Objective-C
``` ObjC
nav.navigation_configuration.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.blueColor};

nav.navigation_configuration.barTintColor = UIColor.redColor;

nav.navigation_configuration.shadowImage = [UIImage imageNamed:@"shadow"];

nav.navigation_configuration.backBarButtonItem = [[BackBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"]];

[nav.navigation_configuration setBackgroundImage:[UIImage imageNamed:@"nav"] for:UIBarPositionAny barMetrics:UIBarMetricsDefault];
```

#### 每个控制器设置
##### 普通设置

Swift
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

// 设置状态栏文字颜色
navigation.bar.statusBarStyle = .lightContent

// 设置返回按钮
navigation.bar.backBarButtonItem = .init(style: .image("Back"), tintColor: .red)

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

// 导航栏阴影
navigation.bar.shadow = Shadow(
    color: UIColor.black.cgColor,
    opacity: 0.5,
    offset: CGSize(width: 0, height: 3))
```

Objective-C
``` ObjC
self.navigation_bar.xxx
self.navigation_item.xxx
```

##### 大标题设置(iOS 11.0+)

UINavigationController
``` swift
// 开启大标题
nav.navigation.prefersLargeTitles()
```
UIViewController
```swift
// 显示或隐藏大标题
navigation.bar.prefersLargeTitles = true

// 设置大标题透明度
navigation.bar.setLargeTitleAlpha(0.5)
```

#### 对于 UITableViewController

请在控制器释放的时候移除观察者

``` swift
deinit {
    removeObserverForContentOffset()
}
```

## 作者

Pircate, gao497868860@163.com

## 许可证

EachNavigationBar 可在 MIT 许可证下使用。有关更多信息，请参阅许可证文件。
