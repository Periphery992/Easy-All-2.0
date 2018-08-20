//
//  UIView+subView.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/8/20.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "UIView+subView.h"

@implementation UIView (subView)

- (void)removeAllSubViews
{
    NSArray *subviews = [self subviews];
    for(UIView *subview in subviews)
    {
        [subview removeFromSuperview];
    }
}

@end
