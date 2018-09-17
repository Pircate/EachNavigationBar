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

## Usage

### Import

``` swift
import EachNavigationBar
```

### Setup (Don't Forget)

``` swift
// before window set rootViewController
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
navigation.bar  -> EachNavigationBar -> UINavigationBar
navigation.item -> UINavigationItem

// hide navigation bar
navigation.bar.isHidden = true

// set alpha
navigation.bar.alpha = 0.5

// remove blur effect
navigation.bar.isTranslucent = false

// hide bottom black line
navigation.bar.shadowImage = UIImage()
// if version < iOS 11.0, also need:
navigation.bar.setBackgroundImage(UIImage(), for: .default)

// if you need to set status bar style lightContent
navigationController?.navigationBar.barStyle = .black

// if you want change navigation bar position
navigation.bar.isUnrestoredWhenViewWillLayoutSubviews = true

// custom back action
navigation.item.leftBarButtonItem?.action = #selector(backBarButtonAction)
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
[AYNavigationBar](https://github.com/Pircate/AYNavigationBar)

## Author

Pircate, gao497868860@163.com

## License

EachNavigationBar is available under the MIT license. See the LICENSE file for more info.
