
//
//  KVOBean.h
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/5/30.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVOBean : NSObject
@property (nonatomic, assign) NSInteger i;
@property (nonatomic, weak) NSObject *observer;

@end
