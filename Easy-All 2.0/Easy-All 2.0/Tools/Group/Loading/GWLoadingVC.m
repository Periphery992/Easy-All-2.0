//
//  GWLoadingVC.m
//  Easy-All 2.0
//
//  Created by Posen on 2018/8/25.
//  Copyright © 2018 陈舒澳. All rights reserved.
//

#import "GWLoadingVC.h"
#import "GWRoleDataManager.h"

@interface GWLoadingVC ()

@end

@implementation GWLoadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i = 1; i <= 40; i++)
    {
        GWRoleDataInfo *roleInfo = [[GWRoleDataInfo alloc]initWithRoleClass:GWRoleClassPaladin_Retribution level:i];
        DDLogVerbose(@"%@",roleInfo);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
