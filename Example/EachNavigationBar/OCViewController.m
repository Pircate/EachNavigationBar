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
    [UIViewController swizzle_setupNavigationBar];
    self.each_navigationBar.barTintColor = UIColor.redColor;
    self.each_navigationItem.title = @"OC";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
