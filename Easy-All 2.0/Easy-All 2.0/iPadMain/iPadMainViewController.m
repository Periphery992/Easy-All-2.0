//
//  iPadMainViewController.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/6/7.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "iPadMainViewController.h"
#import "MainViewController.h"

@interface iPadMainViewController (){}
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIViewController *leftVC;
@property (nonatomic, strong) UIViewController *rightVC;
@end

@implementation iPadMainViewController
#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;

    [self.view addSubview:self.leftView];

    [self setDefaultConstraints];
    [self initLeftViewControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate Methods

#pragma mark - Public Methods

#pragma mark - Private Methods
- (void)initLeftViewControl
{
    UITabBarController *tbvc = [[UITabBarController alloc]init];
    MainViewController *vc1 = [[MainViewController alloc]init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:vc1];
    nav1.tabBarItem.title = @"1";
    NSMutableArray *arr = [NSMutableArray array];
    
    [arr addObject:nav1];
    [tbvc setViewControllers:arr];
    
    [self addChildViewController:tbvc];
    [self.leftView addSubview:tbvc.view];
    
    [tbvc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.leftView);
    }];
    
}

#pragma mark - Layout Methods
- (void)setDefaultConstraints
{

    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.height.mas_equalTo(self.view);
        make.width.mas_offset(320);
    }];
    
}
#pragma mark - Get/Set Methods
- (UIView *)leftView
{
    if (!_leftView)
    {
        _leftView = ({
            
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [UIColor grayColor];
            view;
        });
    }
    return _leftView;

}

@end
