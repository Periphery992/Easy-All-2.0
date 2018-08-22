//
//  HLFPhotoOperationBar.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/8/20.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "HLFPhotoOperationBar.h"

@interface HLFPhotoOperationBar(){}
@property (nonatomic, strong) UIButton *btnAddImage;
@property (nonatomic, strong) UIButton *btnLocation;
@property (nonatomic, strong) UIButton *btnScale;
@property (nonatomic, strong) UILabel *lblNumber;
@property (nonatomic, strong) UIButton *btnTop;
@property (nonatomic, strong) UIButton *btnLeft;
@property (nonatomic, strong) UIButton *btnRight;
@property (nonatomic, strong) UIButton *btnBottom;

@property (nonatomic, strong) UIButton *btnAdd;
@property (nonatomic, strong) UIButton *btnAddMore;
@property (nonatomic, strong) UIButton *btnReduce;
@property (nonatomic, strong) UIButton *btnReduceMore;
@property (nonatomic, strong) UIButton *btnAuto;
@property (nonatomic, strong) UIButton *btnSave;
@property (nonatomic, strong) UIButton *btnBack;
@end

@implementation HLFPhotoOperationBar

#pragma mark - UIView LifeCycle Methods
- (instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.btnSave];
        [self addSubview:self.btnBack];
        [self addSubview:self.btnAddImage];
        [self addSubview:self.btnLocation];
        [self addSubview:self.btnScale];
        [self addSubview:self.lblNumber];
        
        [self addSubview:self.btnTop];
        [self addSubview:self.btnLeft];
        [self addSubview:self.btnRight];
        [self addSubview:self.btnBottom];
        
        [self addSubview:self.btnAdd];
        [self addSubview:self.btnAddMore];
        [self addSubview:self.btnReduce];
        [self addSubview:self.btnReduceMore];
        [self addSubview:self.btnAuto];
        

        [self setDefaultConstraints];
        
    }
    return self;
}

#pragma mark - Delegate Methods

#pragma mark - Public Methods

#pragma mark - Private Methods
- (void)touchBtnImage
{
    [self.delegate photoOperationBarWithOperation:HLFPhotoOperationBarOperationAddImage number:0];
}

- (void)touchBtnAuto
{
    [self.delegate photoOperationBarWithOperation:HLFPhotoOperationBarOperationAuto number:0];
}

- (void)touchBtnBack
{
    [self.delegate photoOperationBarWithOperation:HLFPhotoOperationBarOperationBack number:0];
}

- (void)touchBtnSave
{
    [self.delegate photoOperationBarWithOperation:HLFPhotoOperationBarOperationSave number:0];
}

- (void)touchBtnLocation
{
    if (!self.btnLocation.selected)
    {
        self.btnScale.selected = NO;
        self.btnLocation.selected = YES;
        self.btnTop.selected = YES;
        self.btnLeft.selected = YES;
        self.btnBottom.selected = YES;
        self.btnRight.selected = YES;
        
        self.btnTop.hidden = NO;
        self.btnBottom.hidden = NO;
        
    }
}

- (void)touchBtnScale
{
    if (!self.btnScale.selected)
    {
        self.btnScale.selected = YES;
        self.btnLocation.selected = NO;
        self.btnTop.selected = NO;
        self.btnLeft.selected = NO;
        self.btnBottom.selected = NO;
        self.btnRight.selected = NO;
        
        self.btnTop.hidden = YES;
        self.btnBottom.hidden = YES;
    }
}

- (void)touchOperationBtn:(UIButton *)operationBtn
{
    HLFPhotoOperationBarOperation operation = 1;
    
    if (operationBtn == self.btnLeft)
    {
        operation = self.btnLeft.selected?HLFPhotoOperationBarOperationLeft:HLFPhotoOperationBarOperationNarrow;
    }
    else if (operationBtn == self.btnRight)
    {
        operation = self.btnRight.selected?HLFPhotoOperationBarOperationRight:HLFPhotoOperationBarOperationEnlarge;
    }
    else if (operationBtn == self.btnTop)
    {
        operation = HLFPhotoOperationBarOperationUp;
    }
    else if (operationBtn == self.btnBottom)
    {
        operation = HLFPhotoOperationBarOperationDown;
    }
    else if (operationBtn == self.btnAdd)
    {
        self.lblNumber.text = [NSString stringWithFormat:@"%0.1f",[self.lblNumber.text floatValue]+0.1];
        return;
    }
    else if (operationBtn == self.btnAddMore)
    {
        self.lblNumber.text = [NSString stringWithFormat:@"%0.1f",[self.lblNumber.text floatValue]+1.0];
        return;
    }
    else if (operationBtn == self.btnReduce)
    {
        self.lblNumber.text = [NSString stringWithFormat:@"%0.1f",[self.lblNumber.text floatValue]-0.1];
        return;
    }
    else if (operationBtn == self.btnReduceMore)
    {
        self.lblNumber.text = [NSString stringWithFormat:@"%0.1f",[self.lblNumber.text floatValue]-1];
        return;
    }
    
    [self.delegate photoOperationBarWithOperation:operation number:[self.lblNumber.text floatValue]];
}

#pragma mark - Layout Methods

- (void)setDefaultConstraints
{
    [self.btnBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self);
        make.height.mas_offset(30);
        make.width.mas_offset(50);
    }];
    
    [self.btnAddImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btnBack.mas_right);
        make.top.mas_equalTo(self);
        make.height.mas_offset(30);
        make.width.mas_offset(50);
    }];
    
    [self.btnLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btnAddImage.mas_right);
        make.top.mas_equalTo(self);
        make.height.mas_offset(30);
        make.width.mas_offset(50);
    }];
    
    [self.btnScale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btnLocation.mas_right);
        make.top.mas_equalTo(self);
        make.height.mas_offset(30);
        make.width.mas_offset(50);
    }];
    
    [self.btnAuto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btnScale.mas_right);
        make.top.mas_equalTo(self);
        make.height.mas_offset(30);
        make.width.mas_offset(50);
    }];
    
    [self.btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btnAuto.mas_right);
        make.top.mas_equalTo(self);
        make.height.mas_offset(30);
        make.width.mas_offset(50);
    }];
    
    [self.lblNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY).mas_offset(15);
        make.width.mas_offset(50);
    }];
    
    [self.btnLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.lblNumber.mas_left);
        make.centerY.mas_equalTo(self.lblNumber);
    }];
    
    [self.btnRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lblNumber.mas_right);
        make.centerY.mas_equalTo(self.lblNumber);
    }];

    [self.btnTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.lblNumber.mas_top);
        make.centerX.mas_equalTo(self.lblNumber);
    }];

    [self.btnBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lblNumber.mas_bottom);
        make.centerX.mas_equalTo(self.lblNumber);
    }];

    [self.btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btnRight.mas_right);
        make.centerY.mas_equalTo(self.lblNumber);
    }];

    [self.btnAddMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btnAdd.mas_right);
        make.centerY.mas_equalTo(self.lblNumber);
    }];

    [self.btnReduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.btnLeft.mas_left);
        make.centerY.mas_equalTo(self.lblNumber);
    }];

    [self.btnReduceMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.btnReduce.mas_left);
        make.centerY.mas_equalTo(self.lblNumber);
    }];
}


#pragma mark - GET/SET Methods
- (UIButton *)btnBack
{
    if (!_btnBack)
    {
        _btnBack = ({
            
            UIButton *button = [[UIButton alloc]init];
            [button setNormalTitle:@"返回"];
            [button setNormalTitleColor:HLFColor_Black];
            [button addTouchUpInsideTarget:self action:@selector(touchBtnBack)];
            
            button;
        });
    }
    return _btnBack;
}

- (UIButton *)btnAddImage
{
    if (!_btnAddImage)
    {
        _btnAddImage = ({
            
            UIButton *button = [[UIButton alloc]init];
            [button setNormalTitle:@"添加"];
            [button setNormalTitleColor:HLFColor_Black];
            [button addTouchUpInsideTarget:self action:@selector(touchBtnImage)];
            
            button;
        });
    }
    return _btnAddImage;
}

- (UIButton *)btnLocation
{
    if (!_btnLocation)
    {
        _btnLocation = ({
            
            UIButton *button = [[UIButton alloc]init];
            [button setNormalTitle:@"位置"];
            [button setNormalTitleColor:HLFColor_Black];
            [button setSelectedTitleColor:HLFColor_Red];
            [button addTouchUpInsideTarget:self action:@selector(touchBtnLocation)];
            button.selected = YES;
            button;
        });
    }
    return _btnLocation;
}

- (UIButton *)btnScale
{
    if (!_btnScale)
    {
        _btnScale = ({
            
            UIButton *button = [[UIButton alloc]init];
            [button setNormalTitle:@"大小"];
            [button setNormalTitleColor:HLFColor_Black];
            [button setSelectedTitleColor:HLFColor_Red];
            [button addTouchUpInsideTarget:self action:@selector(touchBtnScale)];
            button;
        });
    }
    return _btnScale;
}

- (UIButton *)btnAuto
{
    if (!_btnAuto)
    {
        _btnAuto = ({
            
            UIButton *button = [[UIButton alloc]init];
            [button setNormalTitle:@"自动"];
            [button setNormalTitleColor:HLFColor_Black];
            [button addTouchUpInsideTarget:self action:@selector(touchBtnAuto)];
            button;
        });
    }
    return _btnAuto;
}

- (UIButton *)btnSave
{
    if (!_btnSave)
    {
        _btnSave = ({
            
            UIButton *button = [[UIButton alloc]init];
            [button setNormalTitle:@"保存"];
            [button setNormalTitleColor:HLFColor_Black];
            [button addTouchUpInsideTarget:self action:@selector(touchBtnSave)];
            button;
        });
    }
    return _btnSave;
}

- (UILabel *)lblNumber
{
    if (!_lblNumber)
    {
        _lblNumber = ({
            
            UILabel *label = [[UILabel alloc]init];
            label.text = @"1";
            label.textAlignment = NSTextAlignmentCenter;
            label;
        });
    }
    return _lblNumber;
}

- (UIButton *)btnTop
{
    if (!_btnTop)
    {
        _btnTop = ({
            
            UIButton *button = [[UIButton alloc]init];
            [button setSelectedTitle:@"上"];
            [button setNormalTitleColor:HLFColor_Black];
            [button addTouchUpInsideTarget:self action:@selector(touchOperationBtn:)];
            button.selected = YES;
            button;
        });
    }
    return _btnTop;
}

- (UIButton *)btnLeft
{
    if (!_btnLeft)
    {
        _btnLeft = ({
            
            UIButton *button = [[UIButton alloc]init];
            [button setSelectedTitle:@"左"];
            [button setNormalTitle:@"小"];
            [button setNormalTitleColor:HLFColor_Black];
            [button addTouchUpInsideTarget:self action:@selector(touchOperationBtn:)];
            button.selected = YES;
            button;
        });
    }
    return _btnLeft;
}

- (UIButton *)btnRight
{
    if (!_btnRight)
    {
        _btnRight = ({
            
            UIButton *button = [[UIButton alloc]init];
            [button setSelectedTitle:@"右"];
            [button setNormalTitle:@"大"];
            [button setNormalTitleColor:HLFColor_Black];
            [button addTouchUpInsideTarget:self action:@selector(touchOperationBtn:)];
            button.selected = YES;
            button;
        });
    }
    return _btnRight;
}

- (UIButton *)btnBottom
{
    if (!_btnBottom)
    {
        _btnBottom = ({
            
            UIButton *button = [[UIButton alloc]init];
            [button setNormalTitle:@"下"];
            [button setNormalTitleColor:HLFColor_Black];
            [button addTouchUpInsideTarget:self action:@selector(touchOperationBtn:)];
            button.selected = YES;
            button;
        });
    }
    return _btnBottom;
}

- (UIButton *)btnAdd
{
    if (!_btnAdd)
    {
        _btnAdd = ({
            
            UIButton *button = [[UIButton alloc]init];
            [button setNormalTitle:@"+0.1"];
            [button setNormalTitleColor:HLFColor_Black];
            [button addTouchUpInsideTarget:self action:@selector(touchOperationBtn:)];
            button;
        });
    }
    return _btnAdd;
}

- (UIButton *)btnAddMore
{
    if (!_btnAddMore)
    {
        _btnAddMore = ({
    
            UIButton *button = [[UIButton alloc]init];
            [button setNormalTitle:@"+1"];
            [button setNormalTitleColor:HLFColor_Black];
            [button addTouchUpInsideTarget:self action:@selector(touchOperationBtn:)];
            button;
        });
    }
    return _btnAddMore;
}

- (UIButton *)btnReduce
{
    if (!_btnReduce)
    {
        _btnReduce = ({
            
            UIButton *button = [[UIButton alloc]init];
            [button setNormalTitle:@"-0.1"];
            [button setNormalTitleColor:HLFColor_Black];
            [button addTouchUpInsideTarget:self action:@selector(touchOperationBtn:)];
            button;
        });
    }
    return _btnReduce;
}

- (UIButton *)btnReduceMore
{
    if (!_btnReduceMore)
    {
        _btnReduceMore = ({
            
            UIButton *button = [[UIButton alloc]init];
            [button setNormalTitle:@"-1"];
            [button setNormalTitleColor:HLFColor_Black];
            [button addTouchUpInsideTarget:self action:@selector(touchOperationBtn:)];
            button;
        });
    }
    return _btnReduceMore;
}



@end
