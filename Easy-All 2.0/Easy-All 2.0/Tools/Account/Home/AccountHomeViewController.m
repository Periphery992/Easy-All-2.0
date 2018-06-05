//
//  AccountHomeViewController.m
//  Easy-All 2.0
//
//  Created by chensa on 2018/5/31.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "AccountHomeViewController.h"
#import "AccountTypeViewController.h"

@interface AccountHomeViewController()
@property (nonatomic, strong)  UIBarButtonItem *rightBarButtonItem;
@end

@implementation AccountHomeViewController

#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
    
}

#pragma mark - Delegate Methods

#pragma mark - Public Methods

#pragma mark - Private Methods
- (void)touchRightBarButtonItem
{
    AccountTypeViewController *vc = [[AccountTypeViewController alloc]init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Layout Methods

#pragma mark - GET/SET Methods
- (UIBarButtonItem *)rightBarButtonItem
{
    if (!_rightBarButtonItem)
    {
        _rightBarButtonItem = ({
            
            UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(touchRightBarButtonItem)];
            
            rightBarButtonItem;
        });
    }
    
    return _rightBarButtonItem;
}

@end
