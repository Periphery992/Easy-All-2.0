
//
//  KVOBean.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/5/30.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "KVOBean.h"

@implementation KVOBean

- (void)dealloc
{
    [self removeObserver:self.observer forKeyPath:@"i"];
}

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    [super addObserver:observer forKeyPath:keyPath options:options context:context];
    self.observer = observer;
    
}

@end
