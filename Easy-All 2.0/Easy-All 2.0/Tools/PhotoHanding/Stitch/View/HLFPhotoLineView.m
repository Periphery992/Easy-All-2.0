//
//  HLFPhotoLineView.m
//  Easy-All 2.0
//
//  Created by 陈舒澳 on 2018/8/17.
//  Copyright © 2018年 陈舒澳. All rights reserved.
//

#import "HLFPhotoLineView.h"
#import "HLFImageCVCell.h"

#define TAG_BUTTON_INDEX 0X1000

@interface HLFPhotoLineView()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *imageViewArray;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, weak) UIViewController *viewController;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *customLayout;

@end

@implementation HLFPhotoLineView

static NSString *const cellId = @"cellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";

#pragma mark - UIView LifeCycle Methods
- (instancetype)init
{
    if (self = [super init])
    {
        self.imageArray = [[NSMutableArray alloc]init];
        self.imageViewArray = [[NSMutableArray alloc]init];
        
        [self addSubview:self.collectionView];
        
        [self setDefaultConstraints];

    }
    return self;
}

#pragma mark - Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.imageArray addObject:originalImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            if ([self.delegate respondsToSelector:@selector(photoLineViewOperation:image:)])
            {
                [self.delegate photoLineViewOperation:HLFPhotoLineViewOperationTypeAdd image:originalImage];
            }
        });
    }];
}


#pragma mark - UICollectView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HLFImageCVCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    if (indexPath.row != self.imageArray.count)
    {
        [cell setImage:self.imageArray[indexPath.row]];
    }
    else
    {
        [cell setImage:nil];
    }
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetHeight(self.frame)-10, CGRectGetHeight(self.frame)-10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.imageArray.count)
    {
        [self openPhotoLibrary];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"想干嘛？", nil) preferredStyle:UIAlertControllerStyleActionSheet];
    
        UIAlertAction *actionDelete = [UIAlertAction actionWithTitle:NSLocalizedString(@"删除", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            if ([self.delegate respondsToSelector:@selector(photoLineViewOperation:image:)])
            {
                [self.delegate photoLineViewOperation:HLFPhotoLineViewOperationTypeDelete image:self.imageArray[indexPath.row]];
            }
            
            [self.imageArray removeObjectAtIndex:indexPath.row];
            [self.collectionView reloadData];
        }];
        [alertController addAction:actionDelete];
        
        UIAlertAction *actionTop = [UIAlertAction actionWithTitle:NSLocalizedString(@"置顶", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([self.delegate respondsToSelector:@selector(photoLineViewOperation:image:)])
            {
                [self.delegate photoLineViewOperation:HLFPhotoLineViewOperationTypeBringToFront image:self.imageArray[indexPath.row]];
            }
        }];
        [alertController addAction:actionTop];
        
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:actionCancel];
        
        [self.viewController presentViewController:alertController animated:YES completion:nil];
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 0);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 4.f;
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
    [self.viewController presentViewController:picker animated:YES completion:nil];
}

#pragma mark - Layout Methods
- (void)setDefaultConstraints
{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}
#pragma mark - GET/SET Methods
- (UIScrollView *)scrollview
{
    if (!_scrollview)
    {
        _scrollview = ({
            
            UIScrollView *scrollview = [[UIScrollView alloc]init];
            
            scrollview;
        });
    }
    return _scrollview;
}

- (UIView *)contentView
{
    if (!_contentView)
    {
        _contentView = ({
            
            UIView *view = [[UIView alloc]init];
            
            view;
        });
    }
    return _contentView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        _collectionView = ({
            
            self.customLayout = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象
            self.customLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            
            UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:self.customLayout];
            collectionView.backgroundColor = [UIColor lightGrayColor];
            collectionView.dataSource = self;
            collectionView.delegate = self;

            [collectionView registerClass:[HLFImageCVCell class] forCellWithReuseIdentifier:cellId];
            [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
            [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
            
            collectionView;
        });
    }
    return _collectionView;
}

- (void)setDelegate:(id<HLFPhotoLineViewDelegate>)delegate
{
    _delegate = delegate;
    self.viewController = (UIViewController *)delegate;
}


@end
