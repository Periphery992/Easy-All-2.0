//
//  UIButton+EasySet.h
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/8/20.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EasySet)

- (void)setNormalTitle:(nullable NSString *)title;

- (void)setSelectedTitle:(nullable NSString *)title;

- (void)setNormalTitleColor:(nullable UIColor *)color;

- (void)setSelectedTitleColor:(nullable UIColor *)color;

- (void)addTouchUpInsideTarget:(nullable id)target action:(nonnull SEL)action;

@end
