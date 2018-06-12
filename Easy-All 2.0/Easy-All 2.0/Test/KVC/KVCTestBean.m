//
//  KVCTestBean.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/6/5.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "KVCTestBean.h"

@interface KVCTestBean()
@property (nonatomic, strong) id testObject;
@property (nonatomic, strong) NSMutableArray *arr;
@end



@implementation KVCTestBean
@synthesize testObject = _testObject;
@synthesize arr = _arr;
- (id)testObject
{
    NSLog(@"%s",__func__);
    return _testObject;
}

- (void)setTestObject:(id)testObject
{
    NSLog(@"%s",__func__);
    _testObject = testObject;
    
}

- (NSMutableArray *)arr
{
    NSLog(@"%s",__func__);
    return _arr;
}

- (void)setArr:(NSMutableArray *)arr
{
    NSLog(@"%s",__func__);
    _arr = arr;
    
}

+ (BOOL)accessInstanceVariablesDirectly
{
    NSLog(@"%s",__func__);
    return [super accessInstanceVariablesDirectly];
}

- (id)valueForKey:(NSString *)key
{
    NSLog(@"%s",__func__);
    return [super valueForKey:key];
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    NSLog(@"%s",__func__);
    [super setValue:value forKey:key];
}

@end
