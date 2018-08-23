//
//  HLFCheckImage.h
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/8/23.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    HLFCheckImageOptimizationNone,          //无特殊优化
    HLFCheckImageOptimizationWeChatLogo,   //微信头像替换模式，优化方案：不存在同一行会有多张头像的情况，及头像之间y坐标没有重合的可能，且如果有多个头像，x坐标是一致的
    HLFCheckImageOptimizationRowNotOverlap,  //横向无重复图片模式，优化方案：不存在同一行会有多张头像的情况，及头像之间y坐标没有重合的可能
} HLFCheckImageOptimization;

@interface HLFCheckImage : NSObject

/**
 创建实例

 @param originalImage 原始图片
 @param rearchImage 查找的图片
 @param replaceImage 用来替换的图片
 @return 实例对象
 */
- (instancetype)initWithOriginalImage:(UIImage *)originalImage rearchImage:(UIImage *)rearchImage replaceImage:(UIImage *)replaceImage;

/**
 设置原图上查找的起始点

 @param point 起始点
 */
- (void)setStartSearchPoint:(CGPoint)point;

/**
 设置图片偏移

 @param offset 设置查找图片用来比对的区域，离四边的距离
 */
- (void)setImageOffset:(UIEdgeInsets)offset;

/**
 设置RGB的允许误差值

 @param offsetArray 允许误差值得数组按顺序为R，G,B
 */
- (void)setRGBValueOffset:(NSArray *)offsetArray;

/**
 设置最大的错误点比例，RGB值误差超过允许误差范围的点的数量比例

 @param rate RGB值误差超过允许误差范围的点的数量比例
 */
- (void)setMaxErrorPointRate:(CGFloat)rate;

/**
 开始替换

 @param optimization 检索优化方案
 @return 返回替换完成后的图片，未找到可以替换的内容返回nil
 */
- (UIImage *)startReplaceWithOptimization:(HLFCheckImageOptimization)optimization;

@end
