//
//  AYNavigation.h
//  UIViewController+EachNavigationBar
//
//  Created by Pircate on 2018/3/28.
//  Copyright © 2018年 Pircate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class EachNavigationBar;
@class EachNavigationConfiguration;

@interface EachNavigation : NSObject

@property (nonatomic, strong) EachNavigationBar *bar;

@property (nonatomic, strong) UINavigationItem *item;

@property (nonatomic, strong) EachNavigationConfiguration *configuration;

@end
