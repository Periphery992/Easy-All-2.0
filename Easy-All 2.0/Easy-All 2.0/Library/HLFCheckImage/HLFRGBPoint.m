//
//  HLFRGBPoint.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/8/23.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "HLFRGBPoint.h"

@implementation HLFRGBPoint

- (BOOL)isEqualPoint:(HLFRGBPoint *)point
{
    if (point.red == self.red
        &&point.green == self.green
        &&point.blue == self.blue
        &&point.alpha == self.alpha)
    {
        return YES;
    }
    return NO;
}

- (BOOL)isSimilarlyPoint:(HLFRGBPoint *)point withRGBValueOffset:(NSArray *)offsetArray
{
    if (abs(self.red - point.red)<[offsetArray[0] integerValue]&&abs(self.green - point.green)<[offsetArray[1] integerValue]&&abs(self.blue - point.green)<[offsetArray[2] integerValue])
    {
        return YES;
    }
    return NO;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"red:%d green:%d blue:%d alpha:%d",self.red,self.green,self.blue,self.alpha];
}

@end
