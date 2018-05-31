//
//  CopyBean.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/5/30.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "CopyBean.h"

@implementation CopyBean

- (instancetype)copyWithZone:(NSZone *)zone
{
    CopyBean *copyBean = [[CopyBean allocWithZone:zone] init];
    copyBean.title = self.title;
    copyBean.name = self.name;
    return copyBean;
}
@end
