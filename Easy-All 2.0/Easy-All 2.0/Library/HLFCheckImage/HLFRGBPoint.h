//
//  HLFRGBPoint.h
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/8/23.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLFRGBPoint : NSObject

@property (nonatomic, assign) int red;
@property (nonatomic, assign) int green;
@property (nonatomic, assign) int blue;
@property (nonatomic, assign) int alpha;

- (BOOL)isEqualPoint:(HLFRGBPoint *)point;

- (BOOL)isSimilarlyPoint:(HLFRGBPoint *)point withRGBValueOffset:(NSArray *)offsetArray;
@end
