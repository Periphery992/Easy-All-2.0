//
//  RuntimeBean.m
//  Easy-All 2.0
//
//  Created by Posen on 2018/7/25.
//  Copyright © 2018 陈舒澳. All rights reserved.
//

#import "RuntimeBean.h"
#import <objc/runtime.h>

@implementation RuntimeBean

//void test (id self, SEL sel)
//{
//    NSLog(@" eat ...... %@ --- %@  ", self, NSStringFromSelector(sel));
//}
//
//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    if (sel == @selector(test2)) {
//
//        // <#__unsafe_unretained Class cls#>  参数1 给哪个类添加方法
//        // <#SEL name#>                       参数2 添加放啊编号
//        // <#IMP imp#>                        参数3 添加方法函数实现 (函数地址)
//        // <#const char *types#>    参数4 函数的类型 (返回值 + 参数类型) v:void @:对象-> self :表示SEL -> _cmd
//
//        class_addMethod(self, @selector(test2), (IMP)test, "v@:");
//    }
//
//    return [super resolveInstanceMethod:sel];
//}


- (void)test
{
    DDLogInfo(@"1");
}

@end
