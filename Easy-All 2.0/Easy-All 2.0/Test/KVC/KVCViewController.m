//
//  KVCViewController.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/6/5.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "KVCViewController.h"
#import "KVCTestBean.h"

@interface KVCViewController ()

@end

@implementation KVCViewController
#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    KVCTestBean *testBean = [[KVCTestBean alloc]init];
    
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:@"1"];
    [arr addObject:@"2"];
    [testBean setValue:arr forKey:@"arr"];
    [testBean valueForKey:@"arr"];
    
    [testBean mutableArrayValueForKey:@"arr"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate Methods

#pragma mark - Public Methods

#pragma mark - Private Methods

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
