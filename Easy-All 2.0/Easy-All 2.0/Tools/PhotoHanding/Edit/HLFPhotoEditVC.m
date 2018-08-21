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

@interface HLFPhotoEditVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,HLFPhotoOperationBarDelegate>
@property (nonatomic, strong) UIImageView *originalImageView;
@property (nonatomic, strong) UIImageView *addingImgView;
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
                self.originalImageView.image = originalImage;
                [self initView];
                
            }
            else
            {
                [self.view addSubview:self.addingImgView];
                
                self.addingImgView.image = originalImage;
                CGSize size = self.addingImgView.image.size;
                CGFloat ratio = size.width/size.height;
                self.addingImgView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame)/ratio);
                
                self.addingImgView.center = self.originalImageView.center;
                
                [self.view bringSubviewToFront:self.operationBar];
            }
        });
    }];
}

- (void)photoOperationBarWithOperation:(HLFPhotoOperationBarOperation)operation number:(CGFloat)number
{
    if (!_addingImgView.superview&&operation != HLFPhotoOperationBarOperationAddImage)
    {
        return;
    }
    
    if (operation == HLFPhotoOperationBarOperationAddImage)
    {
        [self openPhotoLibrary];
    }
    else if (operation == HLFPhotoOperationBarOperationSave)
    {
        [self.addingImgView removeFromSuperview];
        UIImage *image = [self newaddImage:self.addingImgView.image toImage:self.originalImageView.image];
        image = [UIImage imageWithCGImage:image.CGImage scale:self.originalImageView.image.scale orientation:UIImageOrientationUp];
        self.originalImageView.image = image;
        
//        UIImageWriteToSavedPhotosAlbum(image, <#id  _Nullable completionTarget#>, <#SEL  _Nullable completionSelector#>, <#void * _Nullable contextInfo#>)
    }
    else if (operation == HLFPhotoOperationBarOperationNarrow)
    {
        CGSize size = self.addingImgView.image.size;
        
        CGFloat ratio = size.width/size.height;
        
        CGFloat reduceWith = number;
        CGFloat reduceHeight = number/ratio;
        
        self.addingImgView.frame = CGRectMake(self.addingImgView.frame.origin.x + reduceWith/2.0, self.addingImgView.frame.origin.y + reduceHeight/2.0, CGRectGetWidth(self.addingImgView.frame)-reduceWith, CGRectGetHeight(self.addingImgView.frame)-reduceHeight) ;
    }
    else if (operation == HLFPhotoOperationBarOperationEnlarge)
    {
        CGSize size = self.addingImgView.image.size;
        
        CGFloat ratio = size.width/size.height;
        
        CGFloat reduceWith = number;
        CGFloat reduceHeight = number/ratio;
        
        self.addingImgView.frame = CGRectMake(self.addingImgView.frame.origin.x - reduceWith/2.0, self.addingImgView.frame.origin.y - reduceHeight/2.0, CGRectGetWidth(self.addingImgView.frame)+reduceWith, CGRectGetHeight(self.addingImgView.frame)+reduceHeight) ;
    }
    else if (operation == HLFPhotoOperationBarOperationLeft)
    {
        self.addingImgView.center = CGPointMake(CGRectGetMidX(self.addingImgView.frame)-number, CGRectGetMidY(self.addingImgView.frame));
    }
    else if (operation == HLFPhotoOperationBarOperationRight)
    {
        self.addingImgView.center = CGPointMake(CGRectGetMidX(self.addingImgView.frame)+number, CGRectGetMidY(self.addingImgView.frame));
    }
    else if (operation == HLFPhotoOperationBarOperationUp)
    {
        self.addingImgView.center = CGPointMake(CGRectGetMidX(self.addingImgView.frame), CGRectGetMidY(self.addingImgView.frame)-number);
    }
    else if (operation == HLFPhotoOperationBarOperationDown)
    {
        self.addingImgView.center = CGPointMake(CGRectGetMidX(self.addingImgView.frame), CGRectGetMidY(self.addingImgView.frame)+number);
    }
    
}

- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2
{
    UIGraphicsBeginImageContext(self.originalImageView.frame.size);
    //Draw image1
    
    //Draw image2
    [image2 drawInRect:CGRectMake(0, 0, self.originalImageView.frame.size.width, self.originalImageView.frame.size.height)];
    
    [image1 drawInRect:CGRectMake(self.addingImgView.frame.origin.x - self.originalImageView.frame.origin.x, self.addingImgView.frame.origin.y - self.originalImageView.frame.origin.y, self.addingImgView.frame.size.width, self.addingImgView.frame.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
    
}

- (UIImage *)newaddImage:(UIImage *)image1 toImage:(UIImage *)image2
{
    int w = self.originalImageView.frame.size.width;
    int h = self.originalImageView.frame.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextBeginPath(context);
    
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), image2.CGImage);
    CGContextDrawImage(context, CGRectMake(self.addingImgView.frame.origin.x - self.originalImageView.frame.origin.x, self.addingImgView.frame.origin.y - self.originalImageView.frame.origin.y, self.addingImgView.frame.size.width, self.addingImgView.frame.size.height), image1.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage    *newImage = [UIImage imageWithCGImage:imageMasked];
    
    CGImageRelease(imageMasked);
    
    return newImage;
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
    CGSize size = self.originalImageView.image.size;
    CGFloat ratio = size.width/size.height;
    
    [self.originalImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(self.originalImageView.mas_width).dividedBy(ratio);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).mas_offset(-75);
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
            operationBar.delegate = self;
            operationBar;
        });
    }
    return _operationBar;
}

- (UIImageView *)addingImgView
{
    if (!_addingImgView)
    {
        _addingImgView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            
            imageView;
        });
    }
    return _addingImgView;
}

@end
