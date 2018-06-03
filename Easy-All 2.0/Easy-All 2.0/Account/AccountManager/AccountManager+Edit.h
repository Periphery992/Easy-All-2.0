//
//  AccountManager+Edit.h
//  Easy-All 2.0
//
//  Created by chensa on 2018/6/3.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "AccountManager.h"

@interface AccountManager (Edit)
@property (nonatomic, strong) AccountInfo *editAccountInfo;

/**
 开始添加新的账号
 */
- (void)beginAddAccount;


/**
 获取cell的数量

 @return cell的数量
 */
- (NSInteger)getCellCount;

/**
 根据编号获取cell的高度

 @param index 编号
 @return cell的高度
 */
- (CGFloat)getCellHeightWithIndex:(NSInteger)index;

/**
 根据编号获取cell的信息

 @param index 编号
 @return cell的信息
 */
- (AccountCellInfo *)getAccountCellInfoWithIndex:(NSInteger)index;


/**
 设置账户名称

 @param accountName 账户名称
 */
- (void)setAccountName:(NSString *)accountName;

@end
