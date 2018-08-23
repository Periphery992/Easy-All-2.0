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
#import "HLFCheckImage.h"

@interface HLFPhotoEditVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,HLFPhotoOperationBarDelegate>
@property (nonatomic, strong) UIImageView *originalImageView;
@property (nonatomic, strong) UIImageView *addingImgView;
@property (nonatomic, strong) HLFPhotoOperationBar *operationBar;
@property (nonatomic, assign) BOOL isAuto;
@property (nonatomic, strong) UIImage *imgRearch;
@property (nonatomic, strong) UIImage *imgReplace;

@end

@implementation HLFPhotoEditVC
#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
    
    self.imgRearch = [UIImage imageNamed:@"logo_origin"];
    self.imgReplace = [UIImage imageNamed:@"logo_replace"];

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

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)photoOperationBarWithOperation:(HLFPhotoOperationBarOperation)operation number:(CGFloat)number
{

    if (operation == HLFPhotoOperationBarOperationAddImage)
    {
        [self openPhotoLibrary];
    }
    else if (operation == HLFPhotoOperationBarOperationBack)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (operation == HLFPhotoOperationBarOperationSave)
    {
        UIImageWriteToSavedPhotosAlbum(self.originalImageView.image, self, nil, (__bridge void * _Nullable)(self));
    }
    else if (operation == HLFPhotoOperationBarOperationNarrow&&self.addingImgView.superview)
    {
        CGSize size = self.addingImgView.image.size;
        
        CGFloat ratio = size.width/size.height;
        
        CGFloat reduceWith = number;
        CGFloat reduceHeight = number/ratio;
        
        self.addingImgView.frame = CGRectMake(self.addingImgView.frame.origin.x + reduceWith/2.0, self.addingImgView.frame.origin.y + reduceHeight/2.0, CGRectGetWidth(self.addingImgView.frame)-reduceWith, CGRectGetHeight(self.addingImgView.frame)-reduceHeight) ;
    }
    else if (operation == HLFPhotoOperationBarOperationEnlarge&&self.addingImgView.superview)
    {
        CGSize size = self.addingImgView.image.size;
        
        CGFloat ratio = size.width/size.height;
        
        CGFloat reduceWith = number;
        CGFloat reduceHeight = number/ratio;
        
        self.addingImgView.frame = CGRectMake(self.addingImgView.frame.origin.x - reduceWith/2.0, self.addingImgView.frame.origin.y - reduceHeight/2.0, CGRectGetWidth(self.addingImgView.frame)+reduceWith, CGRectGetHeight(self.addingImgView.frame)+reduceHeight) ;
    }
    else if (operation == HLFPhotoOperationBarOperationLeft&&self.addingImgView.superview)
    {
        self.addingImgView.center = CGPointMake(CGRectGetMidX(self.addingImgView.frame)-number, CGRectGetMidY(self.addingImgView.frame));
    }
    else if (operation == HLFPhotoOperationBarOperationRight&&self.addingImgView.superview)
    {
        self.addingImgView.center = CGPointMake(CGRectGetMidX(self.addingImgView.frame)+number, CGRectGetMidY(self.addingImgView.frame));
    }
    else if (operation == HLFPhotoOperationBarOperationUp&&self.addingImgView.superview)
    {
        self.addingImgView.center = CGPointMake(CGRectGetMidX(self.addingImgView.frame), CGRectGetMidY(self.addingImgView.frame)-number);
    }
    else if (operation == HLFPhotoOperationBarOperationDown&&self.addingImgView.superview)
    {
        self.addingImgView.center = CGPointMake(CGRectGetMidX(self.addingImgView.frame), CGRectGetMidY(self.addingImgView.frame)+number);
    }
    else if (operation == HLFPhotoOperationBarOperationAuto)
    {
        self.isAuto = YES;
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.isAuto)
    {
        NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
        UITouch *touch = [allTouches anyObject];   //视图中的所有对象
        CGPoint point = [touch locationInView:self.originalImageView]; //返回触摸点在视图中的当前坐标
        
        point.x = point.x < 0?0:point.x;
        point.y = point.y < 0?0:point.y;

        int x = point.x/CGRectGetWidth(self.originalImageView.frame)*self.originalImageView.image.size.width;
        int y = point.y/CGRectGetHeight(self.originalImageView.frame)*self.originalImageView.image.size.height;
            
        [self startAutoReplaceImageWithStartPoint:CGPointMake(x, y)];
    }
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

- (void)startAutoReplaceImageWithStartPoint:(CGPoint)point
{
    self.isAuto = NO;
    
    DDLogVerbose(@"HLFPhotoEdit startReplace");
    [self.operationBar startAutoTip];
    
    HLFCheckImage *check = [[HLFCheckImage alloc]initWithOriginalImage:self.originalImageView.image rearchImage:self.imgRearch replaceImage:self.imgReplace];
    [check setImageOffset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [check setRGBValueOffset:@[@55,@65,@70]];
    [check setStartSearchPoint:point];
    [check setMaxErrorPointRate:0.18];
    
    UIImage *imgResult = [check startReplaceWithOptimization:HLFCheckImageOptimizationWeChatLogo];
    
    if (!imgResult) //没有找到
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"没有找到可以替换的", nil) preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"好的", nil) style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:actionCancel];
        
        [self.navigationController presentViewController:alertController animated:YES completion:nil];
        
    }
    else //找到了
    {
        self.originalImageView.image = imgResult;
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"搞定啦，保存不?", nil) preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"存你个大头鬼!", nil) style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:actionCancel];
        
        UIAlertAction *actionRetry = [UIAlertAction actionWithTitle:NSLocalizedString(@"存存存", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            UIImageWriteToSavedPhotosAlbum(self.originalImageView.image, self, nil, (__bridge void * _Nullable)(self));
        }];
        [alertController addAction:actionRetry];
        
        [self.navigationController presentViewController:alertController animated:YES completion:nil];
        
    }
    DDLogVerbose(@"HLFPhotoEdit finished");
    [self.operationBar finishAutoTip];
}

#pragma mark - Reload Methods

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
