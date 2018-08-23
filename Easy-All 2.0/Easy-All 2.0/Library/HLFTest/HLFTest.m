//
//  HLFTest.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/8/23.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "HLFTest.h"

@implementation HLFTest

+ (void)memoryWarningTest
{
    // Private API
    SEL sel = NSSelectorFromString([@"_perform" stringByAppendingString:@"MemoryWarning"]);
    assert([[UIApplication sharedApplication] respondsToSelector:sel]);
    [[UIApplication sharedApplication] performSelector:sel];
}

@end
