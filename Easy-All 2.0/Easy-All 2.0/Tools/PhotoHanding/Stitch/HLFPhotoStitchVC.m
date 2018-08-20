//
//  HLFPhotoStitchVC.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/8/17.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "HLFPhotoStitchVC.h"
#import "HLFPhotoLineView.h"

@interface HLFPhotoStitchVC ()<HLFPhotoLineViewDelegate>
@property (nonatomic, strong) HLFPhotoLineView *photoLineView;

@end

@implementation HLFPhotoStitchVC
#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
    [self.view addSubview:self.photoLineView];
    
    [self setDefaultConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate Methods

#pragma mark - Public Methods

#pragma mark - Private Methods
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
#pragma mark - Layout Methods

- (void)setDefaultConstraints
{
    [self.photoLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.height.mas_offset(60);
    }];
}

#pragma mark - Get/Set Methods
- (HLFPhotoLineView *)photoLineView
{
    if (!_photoLineView)
    {
        _photoLineView = ({
            
            HLFPhotoLineView *photoLineView = [[HLFPhotoLineView alloc]init];
            photoLineView.delegate = self;
            photoLineView.backgroundColor = [UIColor blueColor];
            
            photoLineView;
        });
    }
    return _photoLineView;
}

@end

