//
//  KVOViewController.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/5/30.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "KVOViewController.h"
#import "KVOBean.h"

@interface KVOViewController ()

@end

@implementation KVOViewController
#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    KVOBean *bean = [[KVOBean alloc]init];
    [bean addObserver:self forKeyPath:@"i" options:NSKeyValueObservingOptionPrior context:@"1"];
    bean.i = 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate Methods

#pragma mark - Public Methods

#pragma mark - Private Methods
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
}

#pragma mark - Layout Methods

#pragma mark - Get/Set Methods
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
