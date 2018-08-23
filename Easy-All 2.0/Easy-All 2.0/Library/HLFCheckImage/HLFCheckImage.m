//
//  HLFCheckImage.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/8/23.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "HLFCheckImage.h"
#import "HLFRGBPoint.h"

@interface HLFCheckImage(){}
@property (nonatomic, strong) UIImage *imgOriginal;       //原始图片
@property (nonatomic, strong) UIImage *imgRearch;         //查找的图片
@property (nonatomic, strong) UIImage *imgReplace;        //用来替换的图片
@property (nonatomic) UIEdgeInsets imageOffset;           //用来查找图片用来比对的区域，离四边的距离
@property (nonatomic, strong) NSArray *RGBOffsetArray;    //RGB的允许误差值数组
@property (nonatomic, assign) CGFloat maxErrorPointRate;  //RGB值误差超过允许误差范围的点的数量比例
@property (nonatomic, strong) UIImage *imgResult;         //修改后的图片
@property (nonatomic, assign) CGPoint startSearchPoint;   //原图上起始检测点
@property (nonatomic, assign) int iFirstPointX;      //第一次成功换图的横坐标
@property (nonatomic, assign) HLFCheckImageOptimization *optimization;

@end

@implementation HLFCheckImage
//创建实例
- (instancetype)initWithOriginalImage:(UIImage *)originalImage rearchImage:(UIImage *)rearchImage replaceImage:(UIImage *)replaceImage
{
    if (self = [super init])
    {
        self.imgOriginal = originalImage;
        self.imgRearch = rearchImage;
        self.imgReplace = replaceImage;
        self.startSearchPoint = CGPointMake(0, 0);
    }
    return self;
}

- (void)setStartSearchPoint:(CGPoint)point
{
    _startSearchPoint = point;
}

- (void)setImageOffset:(UIEdgeInsets)offset
{
    _imageOffset = UIEdgeInsetsMake(offset.top, offset.left, offset.bottom, offset.right);
}

- (void)setRGBValueOffset:(NSArray *)offsetArray
{
    self.RGBOffsetArray = offsetArray;
}

- (void)setMaxErrorPointRate:(CGFloat)rate
{
    _maxErrorPointRate = rate;
}

//开始替换
- (UIImage *)startReplaceWithOptimization:(HLFCheckImageOptimization)optimization
{
    //获取原始图片的点的rgb数组
    NSMutableArray *originalImagePointArray = [self getRGBPointArrayInImage:self.imgOriginal];
    //获取查找图片的点的rgb数组
    NSMutableArray *rearchImagePointArray = [self getRGBPointArrayInImage:self.imgRearch];
    
    HLFRGBPoint *firstPoint = [[rearchImagePointArray objectAtIndex:self.imageOffset.top] objectAtIndex:self.imageOffset.left];

    for (int iRow = self.startSearchPoint.y; iRow < originalImagePointArray.count-self.imgRearch.size.width; iRow++)
    {
        int iBestLine = self.iFirstPointX <= 0?self.startSearchPoint.x:self.iFirstPointX;
        
        for (int iLine = iBestLine; iLine < [originalImagePointArray[iRow] count] - self.imgRearch.size.height; iLine++)
        {
            if ([firstPoint isSimilarlyPoint:originalImagePointArray[iRow][iLine] withRGBValueOffset:self.RGBOffsetArray])  //查找图片的第一个点，于原图上点相似
            {
                //检测区域图片是否相似
                if ([self checkAreaWithY:iRow x:iLine searchImageRGBPointArray:rearchImagePointArray originalImageRGBPointArray:originalImagePointArray])
                {
                    if (self.iFirstPointX <= 0&&optimization == HLFCheckImageOptimizationWeChatLogo)
                    {//第一次找到可以替换的区域后，后续x轴上的查找范围缩小到从该区域的前10个像素开始
                        self.iFirstPointX = iLine - self.imageOffset.left -10;
                    }
                    
                    self.imgResult = [self replaceImageStartPoint:CGPointMake(iRow - self.imageOffset.top, iLine - self.imageOffset.left)];
                    
                    if (optimization == HLFCheckImageOptimizationWeChatLogo || optimization == HLFCheckImageOptimizationRowNotOverlap)
                    {//微信logo模式、横向无重复模式
                        //数轴上跳过与图片等高的行数
                        iRow = iRow + self.imgRearch.size.height - self.imageOffset.top;
                        //结束当前行的查找
                        iLine = [originalImagePointArray[iRow] count] - self.imgRearch.size.height;
                    }

                }
            }
        }
    }
    return self.imgResult;
}


/**
 检测图片区域是否相识

 @param y 区域起始点的Y值
 @param x 区域起始点的X值
 @param array1 查找图片的点的rgb数组
 @param array2 原始图片的点的rgb数组
 @return 返回是否匹配
 */
- (BOOL)checkAreaWithY:(NSInteger)y x:(NSInteger)x searchImageRGBPointArray:(NSMutableArray *)array1 originalImageRGBPointArray:(NSMutableArray *)array2
{
    NSInteger notSimilarlyPointCount = 0; //不相似点的数量
    NSInteger similarlyPointCount = 0;    //相似点的数量
    
    //区域的行列数
    NSInteger iMaxRow = self.imgRearch.size.height - self.imageOffset.top - self.imageOffset.bottom;
    NSInteger iMaxLine = self.imgRearch.size.width - self.imageOffset.left - self.imageOffset.right;

    //点的总数
    NSInteger pointCount = iMaxRow*iMaxLine;
    
    NSInteger offsetLeft = (NSInteger)self.imageOffset.left;
    NSInteger offsetTop = (NSInteger)self.imageOffset.top;
    
    for (NSInteger iRow = 0; iRow < iMaxRow; iRow ++)
    {
        for (NSInteger iLine = 0; iLine < iMaxLine; iLine ++)
        {
            HLFRGBPoint *rearchPoint = array1[iRow+offsetTop][iLine+offsetLeft];
            HLFRGBPoint *originalPoint = array2[iRow+y][iLine+x];
            
            if (![rearchPoint isSimilarlyPoint:originalPoint withRGBValueOffset:self.RGBOffsetArray])
            {
                notSimilarlyPointCount++;
                
                //不相似点超标，返回失败
                if (notSimilarlyPointCount > pointCount*self.maxErrorPointRate)
                {
                    return NO;
                }
            }
            else
            {
                similarlyPointCount ++;
                //相似点达标，返回成功
                if (similarlyPointCount > pointCount*(1 - self.maxErrorPointRate))
                {
                    return YES;
                }
            }
        }
    }
    return YES;
}

/**
 获取图片的每个点的RGB数组

 @param image 需处理的图片
 @return 图片的每个点的RGB数组
 */
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
                HLFRGBPoint *point = [[HLFRGBPoint alloc]init];
                point.red = ptr[0];
                point.green = ptr[1];
                point.blue = ptr[2];
                [mutRowPointArray addObject:point];
                
                pCurPtr = pCurPtr + 1;
            }
            
            [array addObject:mutRowPointArray];
        }
        
        array;
    });
    
    return image1PointArray;
}

/**
 从指定点开始，替换图片

 @param point 指定替换图片在原始图片上的替换起始点
 @return 替换之后的图
 */
- (UIImage *)replaceImageStartPoint:(CGPoint)point
{
    UIImage *image = self.imgOriginal;
    
    if (self.imgResult)
    {
        image = self.imgResult;
    }
    
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    [self.imgReplace drawInRect:CGRectMake(point.y, point.x, self.imgRearch.size.width, self.imgRearch.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}



@end
