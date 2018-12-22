// 
//  UIViewController+Load.m
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/11/6
//  Copyright © 2018年 Pircate. All rights reserved.
//

#import "UIViewController+Load.h"
#import <EachNavigationBar/EachNavigationBar-Swift.h>

@implementation UIViewController (Load)

+ (void)load {
    [self navigation_methodSwizzling];
}

@end
