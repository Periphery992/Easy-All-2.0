//
//  HLFRunLoopVC.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/8/24.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "HLFRunLoopVC.h"

@interface HLFRunLoopVC (){}
@property (nonatomic, assign) BOOL end;

@end

@implementation HLFRunLoopVC
#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self test];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)test
{
    NSLog(@"test begin");
    
    while (!self.end)
    {
        NSLog(@"while begin");
        // the thread be blocked here
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        NSDate *date = [NSDate distantFuture];
        [runLoop runMode:NSDefaultRunLoopMode beforeDate:date];
        // this will not be executed
        NSLog(@"while end");
        
    }
    
    NSLog(@"while se");
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
