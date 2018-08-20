//
//  HLFPhotoEditVC.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/8/17.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "HLFPhotoEditVC.h"
#import "HLFPhotoLineView.h"
#import "HLFPhotoOperationBar.h"

@interface HLFPhotoEditVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIImageView *originalImageView;
@property (nonatomic, strong) HLFPhotoOperationBar *operationBar;

@end

@implementation HLFPhotoEditVC
#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor blackColor];

    [self openPhotoLibrary];
}

- (void)initView
{
    [self.view addSubview:self.originalImageView];
    [self.view addSubview:self.operationBar];
    
    [self setDefaultConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];

    [picker dismissViewControllerAnimated:YES completion:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (!self.originalImageView.superview)
            {
                [self initView];
                self.originalImageView.image = originalImage;
            }
        });
    }];
}
#pragma mark - Public Methods

#pragma mark - Private Methods
- (void)openPhotoLibrary
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        return;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; // 设置控制器类型
    picker.delegate = self; // 设置代理
    picker.allowsEditing = NO;
    [self presentViewController:picker animated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
#pragma mark - Layout Methods

- (void)setDefaultConstraints
{
    [self.originalImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    
    [self.operationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(150);
        make.bottom.mas_equalTo(self.view);
    }];
}

#pragma mark - Get/Set Methods
- (UIImageView *)originalImageView
{
    if (!_originalImageView)
    {
        _originalImageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            
            imageView;
        });
    }
    return _originalImageView;
}

- (HLFPhotoOperationBar *)operationBar
{
    if (!_operationBar)
    {
        _operationBar = ({
            
            HLFPhotoOperationBar *operationBar = [[HLFPhotoOperationBar alloc]init];
            
            operationBar;
        });
    }
    return _operationBar;
}

@end
