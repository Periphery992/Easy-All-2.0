//
//  MainViewController.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/5/24.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *mainListArrays;
@end

@implementation MainViewController

#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableview];
    
    [self getData];
    [self setDefaultConstraints];
}

#pragma mark - Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


#pragma mark - Public Methods

#pragma mark - Private Methods
- (void)getData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MainList.plist" ofType:nil];
    self.mainListArrays = [NSMutableArray arrayWithContentsOfFile:path];
}

#pragma mark - Layout Methods
- (void)updateViewConstraints
{
    NSLog(@"updateViewConstraints");
    
    [super updateViewConstraints];
}

- (void)setDefaultConstraints
{
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - Get/Set Methods

- (UITableView *)tableview
{
    if (_tableview)
    {
        _tableview = ({
            UITableView *tableview = [[UITableView alloc]init];
            tableview.dataSource = self;
            tableview.delegate = self;
            tableview.tableFooterView = [[UIView alloc]init];
            tableview.backgroundColor = [UIColor redColor];
            tableview;
        });
    }
    return _tableview;
}

- (NSMutableArray *)mainListArrays
{
    if (_mainListArrays)
    {
        _mainListArrays = ({
            
            NSMutableArray *mainListArrays = [[NSMutableArray alloc]init];
            mainListArrays;
        });
    }
    return _mainListArrays;
    
}


@end

