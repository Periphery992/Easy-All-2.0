//
//  SDImageViewController.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/5/31.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "SDImageViewController.h"
#import "UIImageView+WebCache.h"

@interface SDImageViewController ()
@property (nonatomic, strong) UIImageView *testImgView;

@end

@implementation SDImageViewController
#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.testImgView];
    
    [self setDefaultConstraints];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate Methods

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Layout Methods
- (void)setDefaultConstraints
{
    [self.testImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - Get/Set Methods
- (UIImageView *)testImgView
{
    if (!_testImgView)
    {
        _testImgView = ({
            
            UIImageView *testImageView = [[UIImageView alloc]init];
            [testImageView sd_setImageWithURL:[NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/pic/item/8cb1cb13495409237691bcd49e58d109b2de49a4.jpg"]];
            
            testImageView;
        });
    }
    return _testImgView;

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
