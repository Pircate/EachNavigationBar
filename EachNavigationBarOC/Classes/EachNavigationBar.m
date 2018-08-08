//
//  EachNavigationBar.m
//  UIViewController+EachNavigationBar
//
//  Created by Pircate on 2018/3/26.
//  Copyright © 2018年 Pircate. All rights reserved.
//

#import "EachNavigationBar.h"

@interface EachNavigationBar()

@property (nonatomic, assign) CGFloat barBackgroundAlpha;

@end

@implementation EachNavigationBar

- (instancetype)initWithNavigationItem:(UINavigationItem *)navigationItem
{
    self = [super init];
    if (self) {
        _barBackgroundAlpha = 1;
        [self setItems:@[navigationItem]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.subviews.firstObject.alpha = _barBackgroundAlpha;
    self.subviews.firstObject.frame = CGRectMake(0, -CGRectGetMaxY(UIApplication.sharedApplication.statusBarFrame), self.bounds.size.width, self.bounds.size.height + CGRectGetMaxY(UIApplication.sharedApplication.statusBarFrame));
}

- (void)setAlpha:(CGFloat)alpha
{
    _barBackgroundAlpha = alpha;
    self.subviews.firstObject.alpha = alpha;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    self.barTintColor = backgroundColor;
}

- (void)setExtraHeight:(CGFloat)extraHeight
{
    _extraHeight = extraHeight;
    
    CGRect frame = self.frame;
    frame.size.height = 44 + extraHeight;
    self.frame = frame;
}

@end
