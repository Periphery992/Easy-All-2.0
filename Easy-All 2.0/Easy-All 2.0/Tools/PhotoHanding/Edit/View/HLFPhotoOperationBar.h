//
//  HLFPhotoOperationBar.h
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/8/20.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HLFPhotoOperationBarOperationAddImage,
    HLFPhotoOperationBarOperationSave,
    HLFPhotoOperationBarOperationLocation,
    HLFPhotoOperationBarOperationScale,
    HLFPhotoOperationBarOperationUp,
    HLFPhotoOperationBarOperationLeft,
    HLFPhotoOperationBarOperationRight,
    HLFPhotoOperationBarOperationDown,
    HLFPhotoOperationBarOperationEnlarge,
    HLFPhotoOperationBarOperationNarrow
} HLFPhotoOperationBarOperation;

@protocol HLFPhotoOperationBarDelegate<NSObject>

- (void)photoOperationBarWithOperation:(HLFPhotoOperationBarOperation)operation number:(CGFloat)number;

@end

@interface HLFPhotoOperationBar : UIView
@property (nonatomic, weak) id<HLFPhotoOperationBarDelegate> delegate;
@end
