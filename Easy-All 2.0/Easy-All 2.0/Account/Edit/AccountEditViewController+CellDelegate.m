//
//  AccountEditViewController+CellDelegate.m
//  Easy-All 2.0
//
//  Created by chensa on 2018/6/3.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "AccountEditViewController+CellDelegate.h"
#import "AccountNameCell.h"
#import "AccountManager+Edit.h"

@interface AccountEditViewController()
@end

@implementation AccountEditViewController (CellDelegate)

#pragma mark - AccountNameCellDelegate
- (void)accountNameCell:(AccountNameCell *)accountNameCell didEndEditingWithText:(NSString *)text
{
    [[AccountManager sharedInstance] setAccountName:text];
}

@end
