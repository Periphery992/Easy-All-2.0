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
@property (nonatomic, assign) BOOL isAuto;
@property (nonatomic, strong) UIImage *imgOriginal;
@property (nonatomic, strong) UIImage *imgReplace;

@end

@implementation HLFPhotoEditVC
#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
    
    self.imgOriginal = [UIImage imageNamed:@"logo_origin"];
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
         [self findImage:self.imgOriginal inImage:self.originalImageView.image];
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

- (BOOL)findImage:(UIImage *)findingImage inImage:(UIImage *)image
{
    NSMutableArray *image2PointArray = [self getRGBPointArrayInImage:image];
    
    int width = findingImage.size.width;
    
    NSMutableArray *image1PointArray = [self getRGBPointArrayInImage:findingImage];
    
    NSArray *firstPoint = [[image1PointArray objectAtIndex:1] objectAtIndex:1];
    
    for (int i = 0; i < image2PointArray.count-width; i++)
    {
        NSMutableArray *array = [image2PointArray objectAtIndex:i];
        
        for (int j = 0; j < array.count -width; j++)
        {
            NSArray *point = [array objectAtIndex:j];
            
            if ([self isEqualPoint1:point withPoint2:firstPoint])
            {
                
                if ([self checkAreaWithY:i x:j max:width findingImageRGBPointArray:image1PointArray imageRGBPointArray:image2PointArray])
                {
                    self.isAuto = YES;
                    self.originalImageView.image = [self addImage:self.imgReplace toImage:self.originalImageView.image startPoint:CGPointMake(j, i)];
                }
            }
        }
    }
    
    if (!self.isAuto)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"没有找到可以替换的", nil) preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"好的", nil) style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:actionCancel];
        
        [self.navigationController presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"搞定啦，保存不?", nil) preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"存你个大头鬼!", nil) style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:actionCancel];
        
        UIAlertAction *actionRetry = [UIAlertAction actionWithTitle:NSLocalizedString(@"存存存", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            UIImageWriteToSavedPhotosAlbum(self.originalImageView.image, self, nil, (__bridge void * _Nullable)(self));
        }];
        [alertController addAction:actionRetry];
        
        [self.navigationController presentViewController:alertController animated:YES completion:nil];
    }
    
    return YES;
}

- (NSMutableArray *)getRGBPointArrayInImage:(UIImage *)image
{
    NSMutableArray *image1PointArray = [[NSMutableArray alloc]init];
    
    image1PointArray = ({
        
        NSUInteger width = image.size.width;
        NSUInteger height2 = image.size.height;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        NSInteger bytesPerPixel = 4;
        NSInteger bytesPerRow = bytesPerPixel * width;
        NSUInteger bitsPerComponent = 8;
        uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * height2);
        CGContextRef context = CGBitmapContextCreate(rgbImageBuf,
                                                     width,
                                                     height2,
                                                     bitsPerComponent,
                                                     bytesPerRow,
                                                     colorSpace,
                                                     kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
        
        CGColorSpaceRelease(colorSpace);
        CGContextSetBlendMode(context, kCGBlendModeCopy);
        
        
        CGContextDrawImage(context, CGRectMake(0, 0, width, height2), image.CGImage);
        CGContextRelease(context);
        
        uint32_t* pCurPtr = rgbImageBuf;
        
        NSMutableArray *array = [[NSMutableArray alloc]init];
        
        for (NSInteger m = 0; m < height2; m++)
        {
            NSMutableArray *mutRowPointArray = [[NSMutableArray alloc]init];
            
            for (NSInteger iRow = 0; iRow < width; iRow ++)
            {
                uint8_t* ptr = (uint8_t*)pCurPtr;
                [mutRowPointArray addObject:@[[NSNumber numberWithInteger:ptr[0]],[NSNumber numberWithInteger:ptr[1]],[NSNumber numberWithInteger:ptr[2]]]];
                pCurPtr = pCurPtr + 1;
            }
            
            [array addObject:mutRowPointArray];
        }
        
        array;
    });
    
    return image1PointArray;
}

- (BOOL)isEqualPoint1:(NSArray *)point1 withPoint2:(NSArray *)point2
{
    int p1R = [point1[0] intValue];
    int p1G = [point1[1] intValue];
    int p1B = [point1[2] intValue];
    
    int p2R = [point2[0] intValue];
    int p2G = [point2[1] intValue];
    int p2B = [point2[2] intValue];
    
    if (abs(p1R - p2R)<55&&abs(p1G - p2G)<65&&abs(p1B - p2B)<70)
    {
        return YES;
    }
    return NO;
}

- (BOOL)checkAreaWithY:(NSInteger)y x:(NSInteger)x max:(NSInteger)max findingImageRGBPointArray:(NSMutableArray *)array1 imageRGBPointArray:(NSMutableArray *)array2
{
    for (NSInteger i = 0; i < max; i ++)
    {
        for (NSInteger m = 0; m < max; m ++)
        {
            NSArray *point1 = array1[i][m];
            NSArray *point2 = array2[i+y][m+x];
            
            if (![self isEqualPoint1:point1 withPoint2:point2])
            {
                return NO;
            }
        }
    }
    return YES;
}

- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 startPoint:(CGPoint)point
{
    UIGraphicsBeginImageContext(image2.size);
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    [image1 drawInRect:CGRectMake(point.x, point.y, 120, 120)];
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
