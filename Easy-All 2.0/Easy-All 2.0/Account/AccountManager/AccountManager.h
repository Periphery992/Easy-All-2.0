//
//  AccountManager.h
//  Easy-All 2.0
//
//  Created by chensa on 2018/6/3.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountInfo.h"

@interface AccountManager : NSObject

+ (instancetype)sharedInstance;

- (AccountInfo *)getAccountInfoByAccountId:(NSNumber *)accountId;

@end
