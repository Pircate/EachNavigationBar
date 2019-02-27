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
    
    if (@available(iOS 11.0, *)) {
        [self.navigationController navigation_prefersLargeTitles];
    }
    
    self.navigation_bar.backBarButtonItem = [[BackBarButtonItem alloc] initWithTitle:@"" tintColor:nil];
    
    self.navigation_bar.backBarButtonItem.willBack = ^{
        
    };
    
    self.navigation_bar.backBarButtonItem.didBack = ^{
        
    };
    
    self.navigation_bar.backBarButtonItem.shouldBack = ^BOOL(BackBarButtonItem * _Nonnull item) {
        return NO;
    };
}

@end
