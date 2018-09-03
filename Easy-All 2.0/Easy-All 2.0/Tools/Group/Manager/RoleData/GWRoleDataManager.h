//
//  GWRoleDataManager.h
//  Easy-All 2.0
//
//  Created by Posen on 2018/8/24.
//  Copyright © 2018 陈舒澳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWRoleDataInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface GWRoleDataManager : NSObject
@property (nonatomic, strong, readonly) NSDictionary *dicRoleData;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
