//
//  AccountNameCell.m
//  Easy-All 2.0
//
//  Created by chensa on 2018/6/3.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "AccountNameCell.h"
#import "UIImage+HLFExtension.h"

@interface AccountNameCell()<UITextFieldDelegate>
@property (nonatomic, strong) UIButton *btnLogo;
@property (nonatomic, strong) UITextField *nameTxtField;

@end;

@implementation AccountNameCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self.contentView addSubview:self.btnLogo];
        [self.contentView addSubview:self.nameTxtField];
        
        [self setDefaultConstraints];
    }
    
    return self;
}

#pragma mark - UITextField Delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.delegate respondsToSelector:@selector(accountNameCell:didEndEditingWithText:)];
    {
        [self.delegate accountNameCell:self didEndEditingWithText:self.nameTxtField.text];
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidEndEditingNotification object:nil];
    
    self.nameTxtField.delegate = nil;
    [self.nameTxtField resignFirstResponder];
    self.nameTxtField.delegate = self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
}


#pragma mark - Privacy
- (void)touchBtnLogo
{
    
}

#pragma mark - Layout Methods
- (void)setDefaultConstraints
{
    [self.btnLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_offset(60);
        make.top.and.left.mas_offset(15);
    }];
    
    [self.nameTxtField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.width.mas_equalTo(self.contentView).mas_offset(-30);
        make.top.mas_equalTo(self.btnLogo.mas_bottom).mas_offset(15);
        make.height.mas_offset(30);
    }];
    
}

#pragma mark - Set/Get
- (UIButton *)btnLogo
{
    if (!_btnLogo)
    {
        _btnLogo = ({
            
            UIButton *button = [[UIButton alloc]init];
            [button addTarget:self action:@selector(touchBtnLogo) forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = [UIColor redColor];
            button;
        });
    }
    return _btnLogo;
}

- (UITextField *)nameTxtField
{
    if (!_nameTxtField)
    {
        _nameTxtField = ({
            
            UITextField *txtField = [[UITextField alloc]init];
            txtField.layer.cornerRadius = 2;
            txtField.layer.borderWidth = 0.5;
            txtField.layer.borderColor = [UIColor grayColor].CGColor;
            txtField.delegate = self;
            txtField.font = [UIFont systemFontOfSize:14];
            
            txtField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageWithColor:[UIColor clearColor] CGSize:CGSizeMake(10, 30)]];
            txtField.leftViewMode = UITextFieldViewModeAlways;
            
            txtField;
        });
    }
    return _nameTxtField;
}


@end
