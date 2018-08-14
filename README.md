# EachNavigationBar

[![CI Status](http://img.shields.io/travis/Pircate/EachNavigationBar.svg?style=flat)](https://travis-ci.org/Pircate/EachNavigationBar)
[![Version](https://img.shields.io/cocoapods/v/EachNavigationBar.svg?style=flat)](http://cocoapods.org/pods/EachNavigationBar)
[![License](https://img.shields.io/cocoapods/l/EachNavigationBar.svg?style=flat)](http://cocoapods.org/pods/EachNavigationBar)
[![Platform](https://img.shields.io/cocoapods/p/EachNavigationBar.svg?style=flat)](http://cocoapods.org/pods/EachNavigationBar)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

EachNavigationBar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'EachNavigationBar'
```

## Overview

![](https://github.com/Ginxx/EachNavigationBar/blob/master/demo.gif)

## Usage

### Import

``` swift
import EachNavigationBar
```

### Setup

``` swift
// before window set root view controller
UIViewController.setupNavigationBar
```

### To enable EachNavigationBar of a navigation controller

``` swift
let nav = UINavigationController(rootViewController: vc)
nav.navigation.configuration.isEnabled = true
```

### Setting
#### Global

``` swift
let nav = UINavigationController(rootViewController: vc)
nav.navigation.configuration.titleTextAttributes = [.foregroundColor: UIColor.blue]
nav.navigation.configuration.barTintColor = UIColor.red
nav.navigation.configuration.backgroundImage = UIImage(named: "nav")
nav.navigation.configuration.shadowImage = UIImage(named: "shadow")
nav.navigation.configuration.backImage = UIImage(named: "back")
```

#### Each view controller
##### normal

``` swift
navigation.bar  -> UINavigationBar
navigation.item -> UINavigationItem

// Remove blur effect
navigation.bar.isTranslucent = false

// hide bottom black line
navigation.bar.shadowImage = UIImage()
// if version < iOS 11.0, also need:
navigation.bar.setBackgroundImage(UIImage(), for: .default)

// If you need to set status bar style lightContent
navigationController?.navigationBar.barStyle = .black

// If you want change navigation bar position
navigation.bar.isUnrestoredWhenViewWillLayoutSubviews = true
```

##### largeTitle(iOS 11.0+)

``` swift
// enable
if #available(iOS 11.0, *) {
    navigationController?.navigationBar.prefersLargeTitles = true
}
// show
if #available(iOS 11.0, *) {
    navigationItem.largeTitleDisplayMode = .always
}
// hide
if #available(iOS 11.0, *) {
    navigationItem.largeTitleDisplayMode = .never
}
```

### For Objective-C
![AYNavigationBar](https://github.com/Pircate/AYNavigationBar)

## Author

Pircate, gao497868860@163.com

## License

EachNavigationBar is available under the MIT license. See the LICENSE file for more info.
