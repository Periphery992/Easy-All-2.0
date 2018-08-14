//
//  NSThreadViewController.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/8/14.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "NSThreadViewController.h"

@interface NSThreadViewController ()

@property (nonatomic, strong) NSThread *ticketSaleWindow;

@end

@implementation NSThreadViewController
#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.ticketSaleWindow = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicketSafe) object:nil];
    self.ticketSaleWindow.name = @"上海火车票售票窗口";
    
    [self.ticketSaleWindow start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - Delegate Methods

#pragma mark - Public Methods

#pragma mark - Private Methods
- (void)saleTicketSafe
{
    for (int i = 0; i < 10; i++)
    {
        DDLogInfo(@"Task %@", [NSThread currentThread]);
    }
    DDLogInfo(@"Thread Task Complete");
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
