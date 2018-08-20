//
//  RuntimeBean+Property.h
//  Easy-All 2.0
//
//  Created by Posen on 2018/7/29.
//  Copyright © 2018 陈舒澳. All rights reserved.
//

#import "RuntimeBean.h"

@interface RuntimeBean (Property)
@property (nonatomic, copy) NSString *str1;
@property (nonatomic, copy) NSString *str2;

- (void)str222;
- (void)setC:(const void *)c;

@end
