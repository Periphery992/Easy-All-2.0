//
//  RuntimeBean+Property.m
//  Easy-All 2.0
//
//  Created by Posen on 2018/7/29.
//  Copyright © 2018 陈舒澳. All rights reserved.
//

#import "RuntimeBean+Property.h"
#import <objc/runtime.h>

@implementation RuntimeBean (Property)

//const char MJErrorKey = 's';


- (void)setC:(const void *)c
{
    NSLog(@"2");
    
}

- (void)setStr1:(NSString *)str1
{
    objc_setAssociatedObject(self, @"str", str1, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)str1
{
    return objc_getAssociatedObject(self, @"str");
}

- (void)setStr2:(NSString *)str2
{
    objc_setAssociatedObject(self, @"str", str2, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)str2
{
    return objc_getAssociatedObject(self, @"str");
}


- (void)str222
{
    u_int count;
    
    objc_property_t *properties  = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        NSLog(@"属性%@\n",[NSString stringWithUTF8String: propertyName]);
    }
    free(properties);
    
}

@end
