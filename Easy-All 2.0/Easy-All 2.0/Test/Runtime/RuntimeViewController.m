//
//  RuntimeViewController.m
//  Easy-All 2.0
//
//  Created by Posen on 2018/7/19.
//  Copyright © 2018 陈舒澳. All rights reserved.
//

#import "RuntimeViewController.h"
#import <objc/message.h>
#import "RuntimeBean.h"
#import "RuntimeBean+Property.h"
#import <objc/runtime.h>
#import "UIImageView+WebCache.h"

@interface RuntimeViewController ()
@property (nonatomic, assign) NSInteger ix;
@property (nonatomic, strong) RuntimeBean *bean;
@property (nonatomic, strong) UIImageView *test1ImgView;
@property (nonatomic, strong) UIImageView *test2ImgView;
@end

@implementation RuntimeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.test1ImgView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 60, 200, 200)];


    [self.test1ImgView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1533839727042&di=978038b5a07a9a5abdb44d59a115304a&imgtype=0&src=http%3A%2F%2Fp8.qhimg.com%2Ft0195f9c2b488b39cb9.jpg"]];
    
    [self.view addSubview:self.test1ImgView];
    
    self.test2ImgView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 60, 200, 200)];
    
    
    [self.test2ImgView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1533839727041&di=63fda9940ade0c08e253a2392d8f3d71&imgtype=0&src=http%3A%2F%2Fpic4.zhimg.com%2Fv2-788a22f9d265625e2e24b5eadb9620b4_b.jpg"]];
    
    [self.view addSubview:self.test2ImgView];
    
        [self.test1ImgView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1533839727041&di=f9f2ca49c5dbbd73cc7122fdf03908a0&imgtype=0&src=http%3A%2F%2Fimage.bubuko.com%2Finfo%2F201807%2F20180710195309608723.png"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
