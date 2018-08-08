//
//  UIViewController+EachNavigationBar.m
//  UIViewController+EachNavigationBar
//
//  Created by Pircate on 2018/3/26.
//  Copyright © 2018年 Pircate. All rights reserved.
//

#import "UIViewController+EachNavigationBar.h"

#import <objc/runtime.h>

@implementation UIViewController (EachNavigationBar)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *sels = @[@"viewDidLoad", @"viewWillAppear:"];
        [sels enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(obj));
            NSString *swizzledSel = [@"each__" stringByAppendingString:obj];
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(swizzledSel));
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }];
    });
}

- (void)each__viewDidLoad
{
    [self each__viewDidLoad];
    [self bindNavigationBar];
}

- (void)each__viewWillAppear:(BOOL)animated
{
    [self each__viewWillAppear:animated];
    [self bringNavigationBarToFront];
}

- (void)each_adjustsNavigationBarPosition
{
    CGRect barFrame = self.navigationController.navigationBar.frame;
    barFrame.size.height += self.navigation.configuration.extraHeight;
    self.each__navigationBar.frame = barFrame;
    [self.each__navigationBar setNeedsLayout];
}

- (void)bindNavigationBar
{
    if (!self.navigationController) return;
    if (!self.navigationController.navigation.configuration.enabled) return;
    self.navigationController.navigationBar.hidden = YES;
    [self configuraNavigationBarStyle];
    [self.view addSubview:self.each__navigationBar];
}

- (void)bringNavigationBarToFront
{
    if (!self.navigationController) return;
    if (!self.navigationController.navigation.configuration.enabled) return;
    [self.view bringSubviewToFront:self.each__navigationBar];
}

- (void)configuraNavigationBarStyle
{
    EachNavigationConfiguration *configuration = self.navigationController.navigation.configuration;
    self.each__navigationBar.barTintColor = configuration.barTintColor;
    self.each__navigationBar.shadowImage = configuration.shadowImage;
    self.each__navigationBar.titleTextAttributes = configuration.titleTextAttributes;
    [self.each__navigationBar setBackgroundImage:configuration.backgroundImage forBarPosition:configuration.position barMetrics:configuration.metrics];
    self.each__navigationBar.translucent = configuration.translucent;
    self.each__navigationBar.barStyle = configuration.barStyle;
    self.each__navigationBar.extraHeight = configuration.extraHeight;
}

#pragma mark - getter & setter
- (EachNavigationBar *)each__navigationBar
{
    EachNavigationBar *navigationBar = objc_getAssociatedObject(self, _cmd);
    if (!navigationBar) {
        navigationBar = [[EachNavigationBar alloc] initWithNavigationItem:self.each__navigationItem];
        objc_setAssociatedObject(self, @selector(each__navigationBar), navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return navigationBar;
}

- (void)setEach__navigationBar:(EachNavigationBar *)each__navigationBar
{
    objc_setAssociatedObject(self, @selector(each__navigationBar), each__navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UINavigationItem *)each__navigationItem
{
    UINavigationItem *navigationItem = objc_getAssociatedObject(self, _cmd);
    if (!navigationItem) {
        navigationItem = [[UINavigationItem alloc] init];
        objc_setAssociatedObject(self, @selector(each__navigationItem), navigationItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return navigationItem;
}

- (void)setEach__navigationItem:(UINavigationItem *)each__navigationItem
{
    objc_setAssociatedObject(self, @selector(each__navigationItem), each__navigationItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (EachNavigation *)navigation
{
    EachNavigation *navigation = objc_getAssociatedObject(self, _cmd);
    if (!navigation) {
        navigation = [[EachNavigation alloc] init];
        navigation.bar = self.each__navigationBar;
        navigation.item = self.each__navigationItem;
        navigation.configuration = [[EachNavigationConfiguration alloc] init];
        objc_setAssociatedObject(self, @selector(navigation), navigation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return navigation;
}

- (void)setNavigation:(EachNavigation *)navigation
{
    objc_setAssociatedObject(self, @selector(navigation), navigation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UINavigationController (EachNavigationBar)

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    EachNavigationBar *bar = self.topViewController.navigation.bar;
    
    if (!bar) return;
    
    if (@available(iOS 11.0, *)) {
        bar.prefersLargeTitles = self.navigationBar.prefersLargeTitles;
        bar.largeTitleTextAttributes = self.navigationBar.largeTitleTextAttributes;
    }
    
    CGRect frame = bar.frame;
    CGRect barFrame = self.navigationBar.frame;
    if (bar.isUnrestoredWhenViewWillLayoutSubviews) {
        frame.size = barFrame.size;
    }
    else {
        frame = barFrame;
        if (@available(iOS 11.0, *)) {
            if (self.navigationBar.prefersLargeTitles) {
                frame.origin.y = CGRectGetMaxY(UIApplication.sharedApplication.statusBarFrame);
            }
        }
    }
    frame.size.height = barFrame.size.height + bar.extraHeight;
    bar.frame = frame;
}

@end
