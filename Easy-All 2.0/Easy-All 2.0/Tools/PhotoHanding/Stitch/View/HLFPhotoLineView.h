//
//  HLFPhotoLineView.h
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/8/17.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HLFPhotoLineViewOperationTypeAdd,
    HLFPhotoLineViewOperationTypeBringToFront,
    HLFPhotoLineViewOperationTypeDelete,
} HLFPhotoLineViewOperation;

@protocol HLFPhotoLineViewDelegate<NSObject>

@optional
- (void)photoLineViewOperation:(HLFPhotoLineViewOperation)operation image:(UIImage *)image;

@end

@interface HLFPhotoLineView : UIView

@property (nonatomic, weak) id<HLFPhotoLineViewDelegate> delegate;

@end
