//
//  AccountManager.m
//  Easy-All 2.0
//
//  Created by chensa on 2018/6/3.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "AccountManager.h"

@interface AccountManager()
@property (nonatomic, strong) NSMutableArray *accountArray;

@end

@implementation AccountManager

+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[[self class] alloc] init];
    });
    return _sharedInstance;
}

- (void)addAccountByAccountInfo:(AccountInfo *)accountInfo
{
    
}

- (AccountInfo *)getAccountInfoByAccountId:(NSNumber *)accountId
{
    __block AccountInfo *bean = [[AccountInfo alloc]init];
    
    [self.accountArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        bean = (AccountInfo *)obj;
        
        if ([accountId isEqualToNumber:bean.accountId])
        {
            *stop = YES;
        }
    }];
    
    return bean;
}

@end
