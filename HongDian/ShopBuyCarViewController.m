//


//  ShopBuyCarViewController.m
//  HongDian
//
//  Created by 姜通 on 15/7/20.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "ShopBuyCarViewController.h"
#import "AddToCarView.h"
#import "Config.h"
#import "BuyCarViewController.h"

static NSString *kheaderIdentifier = @"kheaderIdentifier_";
static NSString *kfooterIdentifier = @"kfooterIdentifier_";
static NSString *kGoodsPropertyCollectionViewCellID = @"kGoodsPropertyCollectionViewCellID_";
static NSString *kGoodsNumberPropertyCollectionViewCellID = @"kGoodsNumberPropertyCollectionViewCellID";

#define Collection_Cell_Horizon_Margin        10
#define Collection_Cell_Vertical_Margin       10
@interface ShopBuyCarViewController ()

@end

@implementation ShopBuyCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"加入购物车";
    
    AddToCarView *addView = [[AddToCarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    addView.layer.borderWidth = 2;
    addView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:addView];
    
    self.goodsColorArray = @[@"红",@"黄",@"红",@"黄",@"黄"];
    self.goodsSizeArray = @[@"1",@"2",@"11",@"1212",@"32"];
    [self.view addSubview:self.collectionView];
}


-(void)buyThingToCar:(UIButton *)btn{
    BuyCarViewController *buyCar = [[BuyCarViewController alloc] init];
    [self.navigationController pushViewController:buyCar animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;//尺寸和颜色,数量
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 0://尺寸
        {
            return self.goodsSizeArray.count;
            break;
        }
        case 1://颜色
        {
            return self.goodsColorArray.count;
            break;
        }
              default:
            break;
    }
    return 0;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]){
        reuseIdentifier = kheaderIdentifier;
        UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
        for (UIView *subview in view.subviews) {
            if ([subview isKindOfClass:[UILabel class]]) {
                [subview removeFromSuperview];
            }
        }
        UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:15];
        switch (indexPath.section) {
            case 0:
            {
                label.text = @"选择尺码";
                break;
            }
            case 1:
            {
                label.text = @"选择颜色";
                break;
            }
            default:
                break;
        }
        [view addSubview:label];
        return view;
    } else {
        reuseIdentifier = kfooterIdentifier;
        UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind: kind withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
        for (UIView *subview in view.subviews) {
            if ([subview isKindOfClass:[UILabel class]]) {
                [subview removeFromSuperview];
            }
        }
        switch (indexPath.section) {
            case 1:
            {
                UIButton * addToCar = [[UIButton alloc] init];
                addToCar.frame = CGRectMake(30, 20, 100, 40);
                [addToCar addTarget:self action:@selector(buyThingToCar:) forControlEvents:UIControlEventTouchUpInside];
                [addToCar setTitle:@"加入购物车" forState:UIControlStateNormal];
                addToCar.layer.borderColor = [UIColor blackColor].CGColor;
                addToCar.layer.borderWidth = 1;
                [addToCar setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                addToCar.titleLabel.font = [UIFont systemFontOfSize: 14.0];
                addToCar.contentEdgeInsets = UIEdgeInsetsMake(5,10, 5, 10);
                addToCar.layer.cornerRadius = 8;
                addToCar.tag = 1;
                [view addSubview:addToCar];
              
                UIButton * buyNow = [[UIButton alloc] init];
                buyNow.frame = CGRectMake(self.view.frame.size.width - 260 / 2, 20, 100, 40);
                [buyNow addTarget:self action:@selector(buyThingToCar:) forControlEvents:UIControlEventTouchUpInside];
                [buyNow setTitle:@"立即购买" forState:UIControlStateNormal];
                buyNow.layer.borderColor = [UIColor blackColor].CGColor;
                buyNow.layer.borderWidth = 1;
                buyNow.tag = 2;
                buyNow.layer.cornerRadius = 8;
                [buyNow setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                buyNow.titleLabel.font = [UIFont systemFontOfSize: 14.0];
                buyNow.contentEdgeInsets = UIEdgeInsetsMake(5,10, 5, 10);
                [view addSubview:buyNow];
                break;
            }
            default:
                break;
        }
        return view;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGoodsPropertyCollectionViewCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.borderWidth = 2;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    UIView *backGroundView = [[UIView alloc] initWithFrame:cell.bounds];
    backGroundView.backgroundColor = ThemeViewColor;
    [cell setSelectedBackgroundView:backGroundView];
    for (UIView *view in cell.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    UILabel *label = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    switch (indexPath.section) {
        case 0:
        {
            label.text = self.goodsSizeArray[indexPath.row];
            break;
        }
        case 1:
        {
            label.text = self.goodsColorArray[indexPath.row];
            break;
        }
        default:
            break;
    }
    [cell addSubview:label];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {//尺码
            for (int i = 0; i < self.goodsSizeArray.count; i++) {
                UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
                if (![cell isEqual:[collectionView cellForItemAtIndexPath:indexPath]]) {
                    [collectionView deselectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] animated:YES];
                }
            }
            //查找出 颜色 和 大小
//            size_ = self.goodsSizeArray[indexPath.row];
            break;
        }
        case 1:
        {//颜色
            for (int i = 0; i < self.goodsColorArray.count; i++) {
                UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:1]];
                if (![cell isEqual:[collectionView cellForItemAtIndexPath:indexPath]]) {
                    [collectionView deselectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:1] animated:YES];
                }
            }
            //查找出 颜色 和 大小
//            color_ = self.goodsColorArray[indexPath.row];
            break;
        }
        default:
            break;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake((Screen_Width()- 4*Collection_Cell_Horizon_Margin) / 4.0, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return CGSizeMake(Screen_Width(), 50);
    }
    return CGSizeMake(0, 0);
}




-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 50);
        flowLayout.footerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);

        flowLayout.minimumInteritemSpacing = Collection_Cell_Horizon_Margin;
        flowLayout.minimumLineSpacing = Collection_Cell_Vertical_Margin;

        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, Screen_Width(), Screen_Height() - 64 -100) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        //允许多选
        _collectionView.allowsMultipleSelection = YES;
        //默认选中第一个
        [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:0];
        [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1] animated:NO scrollPosition:0];
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kGoodsPropertyCollectionViewCellID];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kGoodsNumberPropertyCollectionViewCellID];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kfooterIdentifier];
    }
    return _collectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
