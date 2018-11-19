# EachNavigationBar

[![CI Status](http://img.shields.io/travis/Pircate/EachNavigationBar.svg?style=flat)](https://travis-ci.org/Pircate/EachNavigationBar)
[![Version](https://img.shields.io/cocoapods/v/EachNavigationBar.svg?style=flat)](http://cocoapods.org/pods/EachNavigationBar)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/EachNavigationBar.svg?style=flat)](http://cocoapods.org/pods/EachNavigationBar)
![iOS 9.0+](https://img.shields.io/badge/iOS-9.0%2B-blue.svg)
[![中文文档](https://woolson.gitee.io/npmer-badge/-007ec6-%E4%B8%AD%E6%96%87%E6%96%87%E6%A1%A3-007ec6-github-ffffff-square-gradient-shadow.svg)](https://github.com/Pircate/EachNavigationBar/blob/master/README_CN.md)

[中文文档](https://github.com/Pircate/EachNavigationBar/blob/master/README_CN.md)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 9.0
* Swift 4.2

## Installation

EachNavigationBar is available through [CocoaPods](http://cocoapods.org) or [Carthage](https://github.com/Carthage/Carthage). To install
it, simply add the following line to your Podfile or Cartfile:

#### Podfile

```ruby
pod 'EachNavigationBar'
```

#### Cartfile
```ruby
github "Pircate/EachNavigationBar"
```

## Overview

![](https://github.com/Pircate/EachNavigationBar/blob/master/demo_new.gif)
![](https://github.com/Pircate/EachNavigationBar/blob/master/demo_push.gif)

## Usage

### Import

Swift
``` swift
import EachNavigationBar
```
Objective-C
``` ObjC
@import EachNavigationBar;
```

### Enable

Swift
``` swift
let nav = UINavigationController(rootViewController: vc)
nav.navigation.configuration.isEnabled = true
```

Objective-C
``` ObjC
UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
nav.global_configuration.isEnabled = YES;
```

### Setting
#### Global

Swift
``` swift
nav.navigation.configuration.titleTextAttributes = [.foregroundColor: UIColor.blue]
nav.navigation.configuration.barTintColor = UIColor.red
nav.navigation.configuration.shadowImage = UIImage(named: "shadow")
nav.navigation.configuration.backImage = UIImage(named: "back")
nav.navigation.configuration.setBackgroundImage(UIImage(named: "nav"), for: .any, barMetrics: .default)
```

Objective-C
``` ObjC
nav.global_configuration.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.blueColor};
nav.global_configuration.barTintColor = UIColor.redColor;
nav.global_configuration.shadowImage = [UIImage imageNamed:@"shadow"];
nav.global_configuration.backImage = [UIImage imageNamed:@"back"];
[nav.global_configuration setBackgroundImage:[UIImage imageNamed:@"nav"] for:UIBarPositionAny barMetrics:UIBarMetricsDefault];
```

#### Each view controller
##### Normal

Swift
``` swift
navigation.bar  -> EachNavigationBar -> UINavigationBar
navigation.item -> UINavigationItem

// hide navigation bar
navigation.bar.isHidden = true

// set bar alpha
navigation.bar.alpha = 0.5

// set title alpha
navigation.bar.setTitleAlpha(0.5)

// set barButtonItem alpha
navigation.bar.setTintAlpha(0.5)
// if barButtonItem is customView
navigation.item.leftBarButtonItem?.customView?.alpha = 0.5
// if barButtonItem customized tintColor
navigation.item.leftBarButtonItem?.tintColor = navigation.item.leftBarButtonItem?.tintColor?.withAlphaComponent(0.5)

// remove blur effect
navigation.bar.isTranslucent = false

// hide bottom black line
navigation.bar.isShadowHidden = true

// set status bar style
navigation.bar.statusBarStyle = .lightContent

// if you want change navigation bar position
navigation.bar.isUnrestoredWhenViewWillLayoutSubviews = true

// navigation bar extra height
navigation.bar.extraHeight = 14

// custom back action
navigation.item.leftBarButtonItem?.action = #selector(backBarButtonAction)
```

Objective-C
``` ObjC
self.each_navigationBar.xxx
self.each_navigationItem.xxx
```

##### LargeTitle(iOS 11.0+)

Swift
``` swift
// show
if #available(iOS 11.0, *) {
    navigation.bar.prefersLargeTitles = true
}
// hide
if #available(iOS 11.0, *) {
    navigation.bar.prefersLargeTitles = false
}
// alpha
if #available(iOS 11.0, *) {
    navigation.bar.setLargeTitleAlpha(0.5)
}
```

Objective-C
``` ObjC
// show
if (@available(iOS 11.0, *)) {
    self.each_navigationBar.prefersLargeTitles = YES;
}
// hide
if (@available(iOS 11.0, *)) {
    self.each_navigationBar.prefersLargeTitles = NO;
}
// alpha
if (@available(iOS 11.0, *)) {
    [self.each_navigationBar setLargeTitleAlpha:0.5];
}
```
#### Adjusts UIScrollView contentInset

Swift
``` swift
adjustsScrollViewContentInset(scrollView)
```

Objective-C
``` ObjC
[self adjustsScrollViewContentInset:self.scrollView];
```

#### For UITableViewController

Must remove observer when deinit

Swift
``` swift
deinit {
    removeObserverForContentOffset()
}
```

Objective-C
``` ObjC
- (void)dealloc {
    [self removeObserverForContentOffset];
}
```
## Author

Pircate, gao497868860@163.com

## License

EachNavigationBar is available under the MIT license. See the LICENSE file for more info.
