//
//  UIViewController+EachNavigationBar.h
//  UIViewController+EachNavigationBar
//
//  Created by Pircate on 2018/3/26.
//  Copyright © 2018年 Pircate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EachNavigation.h"
#import "EachNavigationBar.h"
#import "EachNavigationConfiguration.h"

@interface UIViewController (EachNavigationBar)

@property (nonatomic, strong) EachNavigation *navigation;

- (void)each_adjustsNavigationBarPosition;

@end

@interface UINavigationController (EachNavigationBar)

@end
