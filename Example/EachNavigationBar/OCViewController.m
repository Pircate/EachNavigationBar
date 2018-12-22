// 
//  OCViewController.m
//  EachNavigationBar_Example
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/10/25
//  Copyright © 2018 CocoaPods. All rights reserved.
//

#import "OCViewController.h"
@import EachNavigationBar;

@interface OCViewController ()

@end

@implementation OCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigation_bar.barTintColor = UIColor.redColor;
    self.navigation_item.title = @"OC";
}

@end
