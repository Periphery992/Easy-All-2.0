//
//  AccountTypeViewController.m
//  Easy-All 2.0
//
//  Created by chensa on 2018/6/3.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "AccountTypeViewController.h"
#import "AccountEditViewController.h"

@interface AccountTypeViewController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;

@end

@implementation AccountTypeViewController

#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableview];
    
    [self setDefaultConstraints];
}

#pragma mark - Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *commonCell = @"commonCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commonCell];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:commonCell];
        
    }
    
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"Login";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0)
    {
        AccountEditViewController *vc = [[AccountEditViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Layout Methods
- (void)setDefaultConstraints
{
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - GET/SET Methods
- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = ({
            
            UITableView *tableview = [[UITableView alloc]init];
            tableview.dataSource = self;
            tableview.delegate = self;
            tableview.tableFooterView = [[UIView alloc]init];
            
            tableview;
        });
    }
    return _tableview;
}
@end
