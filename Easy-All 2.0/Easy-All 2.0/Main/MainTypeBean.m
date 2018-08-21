//
//  MainTypeBean.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/5/28.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "MainTypeBean.h"

@implementation MainTypeBean

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"mainToolList":@"list"};
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"mainToolList":@"MainToolBean"};
}



@end
