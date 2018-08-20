//
//  UIButton+EasySet.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/8/20.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "UIButton+EasySet.h"

@implementation UIButton (EasySet)

#pragma mark - Title
- (void)setNormalTitle:(nullable NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setSelectedTitle:(nullable NSString *)title
{
    [self setTitle:title forState:UIControlStateSelected];
}

- (void)setNormalTitleColor:(nullable UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
}

- (void)setSelectedTitleColor:(nullable UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateSelected];
}


#pragma mark - Action
- (void)addTouchUpInsideTarget:(nullable id)target action:(nonnull SEL)action
{
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}
@end
