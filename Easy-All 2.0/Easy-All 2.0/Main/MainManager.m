//
//  MainManager.m
//  Easy-All 2.0
//
//  Created by chensa on 2018/5/29.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "MainManager.h"

@implementation MainManager

+ (instancetype)sharedInstance{
    
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[[self class] alloc] init];
    });
    return _sharedInstance;
}

- (NSInteger)getTypeCount
{
    return self.mainListArrays.count;
}

- (NSInteger)getToolsCountWithTypeIndex:(NSInteger)index
{
    MainTypeBean *bean = self.mainListArrays[index];
    return bean.mainToolList.count;
}

- (NSString *)getTypeWithTypeIndex:(NSInteger)index
{
    MainTypeBean *typeBean = self.mainListArrays[index];
    
    return typeBean.type;
}

- (MainToolBean *)getMainToolBeanWithIndexPath:(NSIndexPath *)indexPath
{
    MainTypeBean *typeBean = self.mainListArrays[indexPath.section];
    MainToolBean *toolBean = typeBean.mainToolList[indexPath.row];
    
    return toolBean;
}

- (NSMutableArray *)mainListArrays
{
    if (!_mainListArrays)
    {
        _mainListArrays = ({
            NSString *path = [[NSBundle mainBundle] pathForResource:@"MainList.plist" ofType:nil];
            NSMutableArray *mainListArrays = [MainTypeBean mj_objectArrayWithKeyValuesArray:[NSMutableArray arrayWithContentsOfFile:path]];
            
            mainListArrays;
        });
    }
    return _mainListArrays;
}

@end
