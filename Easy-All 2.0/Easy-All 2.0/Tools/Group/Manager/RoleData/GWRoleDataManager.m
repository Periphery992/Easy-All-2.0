//
//  GWRoleDataManager.m
//  Easy-All 2.0
//
//  Created by Posen on 2018/8/24.
//  Copyright © 2018 陈舒澳. All rights reserved.
//

#import "GWRoleDataManager.h"

@interface GWRoleDataManager(){}
@property (nonatomic, strong) NSMutableArray *roleArray;
@property (nonatomic, strong, readwrite) NSDictionary *dicRoleData;
@end

@implementation GWRoleDataManager

+ (instancetype)sharedInstance{
    
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[[self class] alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - GET/SET
- (NSDictionary *)dicRoleData
{
    if (!_dicRoleData)
    {
        _dicRoleData = ({
            
            NSDictionary *dictinary = [NSDictionary dictionary];
            NSString *path = [[NSBundle mainBundle]pathForResource:@"RoleData" ofType:@"plist"];
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if ([fileManager fileExistsAtPath:path])
            {
                dictinary = [[NSDictionary alloc]initWithContentsOfFile:path];
            }
            
            dictinary;
        });
    }
    return _dicRoleData;
}

@end
