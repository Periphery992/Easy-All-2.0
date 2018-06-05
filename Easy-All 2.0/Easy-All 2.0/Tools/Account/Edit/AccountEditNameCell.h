//
//  AccountNameCell.h
//  Easy-All 2.0
//
//  Created by chensa on 2018/6/3.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AccountEditNameCell;

@protocol AccountNameCellDelegate<NSObject>

@optional
- (void)accountNameCell:(AccountEditNameCell *)accountNameCell didEndEditingWithText:(NSString *)text;

@end

@interface AccountEditNameCell : UITableViewCell
@property (nonatomic, weak) id<AccountNameCellDelegate> delegate;

@end
