//
//  AccountManager+Edit.m
//  Easy-All 2.0
//
//  Created by chensa on 2018/6/3.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "AccountManager+Edit.h"

@implementation AccountManager (Edit)

// 开始添加新的账号
- (void)beginAddAccount
{
    self.editAccountInfo = [[AccountInfo alloc]init];
    
    AccountCellInfo *accountCellInfo = [[AccountCellInfo alloc]init];
    accountCellInfo.type = AccountCellTypeName;
    accountCellInfo.iNo = 0;
    
    [self.editAccountInfo.accountCellInfoArray addObject:accountCellInfo];
}

// 获取cell的数量
- (NSInteger)getCellCount
{
    return self.editAccountInfo.accountCellInfoArray.count;
}

// 根据编号获取cell的高度
- (CGFloat)getCellHeightWithIndex:(NSInteger)index
{
    AccountCellInfo *accountCellInfo = [self.editAccountInfo.accountCellInfoArray objectAtIndex:index];
    
    return [self getCellHeightWithAccountCellType:accountCellInfo.type];
}

// 根据编号获取cell的信息
- (AccountCellInfo *)getAccountCellInfoWithIndex:(NSInteger)index
{
    return [self.editAccountInfo.accountCellInfoArray objectAtIndex:index];
}

//设置账户名称
- (void)setAccountName:(NSString *)name
{
    AccountCellInfo *accountCellInfo = [self.editAccountInfo.accountCellInfoArray objectAtIndex:0];
    accountCellInfo.content = name;
}

#pragma mark - Privacy
// 根据cell的类型获取cell的高度
- (CGFloat)getCellHeightWithAccountCellType:(AccountCellType)accountCellType
{
    switch (accountCellType) {
        case AccountCellTypeName:
            return 130;
            break;
            
        default:
            return 0;
            break;
    }
}

#pragma mark - Set/Get
- (AccountInfo *)editAccountInfo
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEditAccountInfo:(AccountInfo *)editAccountInfo
{
    objc_setAssociatedObject(self, @selector(editAccountInfo), editAccountInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
