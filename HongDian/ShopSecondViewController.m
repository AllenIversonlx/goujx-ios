

//
//  ShopSecondViewController.m
//  HongDian
//
//  Created by 姜通 on 15/8/7.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "ShopSecondViewController.h"
#import "JXRequestManager.h"
#import "ShopListCollectionViewCell.h"
#import "Config.h"
#import <Masonry/Masonry.h>
#import "ShopHeaderCollectionReusableView.h"
#import "JXRequestManager.h"
#import "ShopDetailViewController.h"

#define ShopListCollectionView @"ShopListCollectionViewCell"
static NSString *kheaderIdentifier = @"headerIdentifier";
static NSString *kfooterIdentifier = @"footIdentifier";
static NSString *kGoodsPropertyCollectionViewCellID = @"kGoodsPropertyCollectionViewCellID_";
static NSString *kGoodsNumberPropertyCollectionViewCellID = @"kGoodsNumberPropertyCollectionViewCellID";

@interface ShopSecondViewController ()

@end

@implementation ShopSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackGroundColor;
    [self.view addSubview:self.collectionView];

    
    [[JXRequestManager sharedNetWorkManager] RequestListMallProductWithMallProductSearch:@"" Success:^(NSArray *array) {
        
    } failture:^(NSString *errMsg) {
        
    }];
}


#pragma mark -UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ShopListCollectionView forIndexPath:indexPath];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(Screen_Width(), 60);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(Screen_Width(), 402);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]){
        reuseIdentifier = kheaderIdentifier;
        ShopHeaderCollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
        view.backgroundColor = [UIColor whiteColor];
        return view;
    } else {
        reuseIdentifier = kfooterIdentifier;
        UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind: kind withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
        view.layer.borderColor = [UIColor lightGrayColor].CGColor;
        view.layer.borderWidth = 0.5;
        UIButton *button = [[UIButton alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [button setTitle:@"查看所有美物" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:UserFont size:13];
        [view addSubview:button];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(lookAllGoods) forControlEvents:UIControlEventTouchUpInside];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view.mas_centerX);
            make.centerY.equalTo(view.mas_centerY);
        }];
        return view;
    }
}

-(void)lookAllGoods{
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SingleGoodsViewController *shopDetail = [[SingleGoodsViewController alloc] init];
    [self.navigationController pushViewController:shopDetail animated:YES];
}


-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.itemSize = CGSizeMake(Screen_Width() / 2 , Screen_Width() / 2 + 72);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,Screen_Width(),Screen_Height() - 64) collectionViewLayout:flowLayout];
        
        [_collectionView registerClass:[ShopListCollectionViewCell class] forCellWithReuseIdentifier:ShopListCollectionView];
        _collectionView.delegate = self;
        _collectionView.dataSource  = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        //设置头或者尾部
        [_collectionView registerClass:[ShopHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kfooterIdentifier];
        
    }
    return  _collectionView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
