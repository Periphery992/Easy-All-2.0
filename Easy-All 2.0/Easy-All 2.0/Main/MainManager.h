//
//  MainManager.h
//  Easy-All 2.0
//
//  Created by chensa on 2018/5/29.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainTypeBean.h"

@interface MainManager : NSObject
@property (nonatomic, strong) NSMutableArray *mainListArrays;

/**
 获取类别总数

 @return 类别总数
 */
- (NSInteger)getTypeCount;

/**
 通过类别序号获取该类别工具的数量

 @param index 类别序号
 @return 该类别工具的数量
 */
- (NSInteger)getToolsCountWithTypeIndex:(NSInteger)index;

/**
 通过类别序号-工具序号获取工具模型

 @param indexPath 类别序号-工具序号
 @return 工具模型
 */
- (MainToolBean *)getMainToolBeanWithIndexPath:(NSIndexPath *)indexPath;

/**
 通过类别序号获取该类别名称

 @param index 类别序号
 @return 类别名称
 */
- (NSString *)getTypeWithTypeIndex:(NSInteger)index;



@end
