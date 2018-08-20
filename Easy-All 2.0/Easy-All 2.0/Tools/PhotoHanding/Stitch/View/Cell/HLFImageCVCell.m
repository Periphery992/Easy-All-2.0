//
//  HLFImageCVCell.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/8/20.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "HLFImageCVCell.h"

@interface HLFImageCVCell(){}
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation HLFImageCVCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self.contentView addSubview:self.imageView];
        
        [self setDefaultConstraints];
    }
    
    return self;
}

- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}

#pragma mark - Layout

- (void)setDefaultConstraints
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}


#pragma mark - SET/GET

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.layer.borderColor = [UIColor whiteColor].CGColor;
            imageView.layer.borderWidth = 0.5;
            
            imageView;
        });
    }
    return _imageView;
}

@end
