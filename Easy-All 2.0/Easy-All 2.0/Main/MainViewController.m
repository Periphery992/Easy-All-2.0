//
//  MainViewController.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/5/24.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "MainViewController.h"
#import "MainManager.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) MainManager *mainManager;

@end

@implementation MainViewController

#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainManager = [[MainManager alloc] init];
    
    [self.view addSubview:self.tableview];
    [self setDefaultConstraints];
}

#pragma mark - Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.mainManager getTypeCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mainManager getToolsCountWithTypeIndex:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.mainManager getTypeWithTypeIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mainListCell = @"mainListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainListCell];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:mainListCell];
        
        MainToolBean *bean = [self.mainManager getMainToolBeanWithIndexPath:indexPath];
        
        cell.textLabel.text = bean.name;
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MainToolBean *bean = [self.mainManager getMainToolBeanWithIndexPath:indexPath];
    
    UIViewController *vc = [[NSClassFromString(bean.viewController) alloc]init];
    
    if([bean.name isEqualToString:@"Tally"])
    {
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        nav.tabBarItem.title = bean.name;
        nav.tabBarItem.image = [[UIImage imageNamed:@"tally_tabbar_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tally_tabbar_home_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        NSMutableArray *viewsControllers  = [NSMutableArray array];
        [viewsControllers addObject:nav];
        
        UITabBarController *tab = [[UITabBarController alloc]init];
        [tab setViewControllers:viewsControllers];
        
        [UIApplication sharedApplication].keyWindow.rootViewController = tab;
    }

    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - Public Methods

#pragma mark - Private Methods

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

