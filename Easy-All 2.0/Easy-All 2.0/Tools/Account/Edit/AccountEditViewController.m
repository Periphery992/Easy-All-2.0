//
//  AccountEditViewController.m
//  Easy-All 2.0
//
//  Created by chensa on 2018/6/2.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "AccountEditViewController.h"
#import "AccountManager+Edit.h"
#import "AccountEditNameCell.h"


@interface AccountEditViewController()<UITableViewDelegate,UITableViewDataSource,AccountNameCellDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong)  UIBarButtonItem *rightBarButtonItem;
@end

@implementation AccountEditViewController

#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [[AccountManager sharedInstance] beginAddAccount];
    
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
    [self.view addSubview:self.tableview];
    
    [self setDefaultConstraints];
}

#pragma mark - Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[AccountManager sharedInstance]getCellCount];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[AccountManager sharedInstance]getCellHeightWithIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccountCellInfo *cellInfo = [[AccountManager sharedInstance]getAccountCellInfoWithIndex:indexPath.row];
    
    if (cellInfo.type == AccountCellTypeName)
    {
        static NSString *accountNameCell = @"accountNameCell";
        AccountEditNameCell *cell = [tableView dequeueReusableCellWithIdentifier:accountNameCell];
        
        if (cell == nil)
        {
            cell = [[AccountEditNameCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:accountNameCell];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
        
    }
    return nil;
}



#pragma mark - Public Methods

#pragma mark - Private Methods
- (void)touchRightBarButtonItem
{
    [[NSNotificationCenter defaultCenter]postNotificationName:UITextFieldTextDidEndEditingNotification object:nil];
}


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

- (UIBarButtonItem *)rightBarButtonItem
{
    if (!_rightBarButtonItem)
    {
        _rightBarButtonItem = ({
            
            UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(touchRightBarButtonItem)];
            
            rightBarButtonItem;
        });
    }
    
    return _rightBarButtonItem;
}

@end
