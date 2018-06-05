//
//  AccountBean.h
//  Easy-All 2.0
//
//  Created by chensa on 2018/6/3.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountCellInfo.h"

@interface AccountInfo : NSObject
@property (nonatomic, strong) NSNumber *accountId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray<AccountCellInfo *> *accountCellInfoArray;

@end
