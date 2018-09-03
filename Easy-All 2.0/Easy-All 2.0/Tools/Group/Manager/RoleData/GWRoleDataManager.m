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

- (instancetype)init
{
    if (self = [super init])
    {
        self.dicRoleData = [NSDictionary dictionary];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"RoleData" ofType:@"plist"];
        
        if ([fileManager fileExistsAtPath:path])
        {
            NSData *data = [fileManager contentsAtPath:path];
            
            if (data.length > 0)
            {
                
                NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                self.dicRoleData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                
                DDLogInfo(@"%@",receiveStr);
            }
        }
    }
    
    return self;
}


@end
