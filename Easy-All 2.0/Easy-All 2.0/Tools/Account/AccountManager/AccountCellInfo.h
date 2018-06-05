//
//  AccountCellInfo.h
//  Easy-All 2.0
//
//  Created by chensa on 2018/6/3.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    AccountCellTypeName,
    AccountCellTypeText,
    AccountCellTypePassword,
} AccountCellType;

@interface AccountCellInfo : NSObject
@property (nonatomic, assign) AccountCellType type;
@property (nonatomic, assign) NSInteger iNo;
@property (nonatomic, copy) NSString *content;

@end
