


//
//  ShopListViewController.m
//  HongDian
//
//  Created by 姜通 on 15/8/18.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "ShopListViewController.h"
#import "JXRequestManager.h"
#import "TitleModel.h"
#import "ShopListModel.h"
#import "HeadScrollView.h"

#define ShopListCollectionView @"ShopListCollectionViewCell"
static NSString *kheaderIdentifier = @"headerIdentifier";
static NSString *kfooterIdentifier = @"footIdentifier";
static NSString *kGoodsPropertyCollectionViewCellID = @"kGoodsPropertyCollectionViewCellID_";
static NSString *kGoodsNumberPropertyCollectionViewCellID = @"kGoodsNumberPropertyCollectionViewCellID";
@interface ShopListViewController ()

@end

@implementation ShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];


    [[JXRequestManager sharedNetWorkManager] RequestListMallProductClassSuccess:^(NSArray *mallProductArray) {
        HeadScrollView *headScrollView = [[HeadScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 44) WithArray:mallProductArray];
        headScrollView.tapScrollButtonBlock = ^(NSDictionary *dic){
          
        };
        [self.view addSubview:headScrollView];
    } failture:^(NSString *errMsg) {
        
    }];
    
    
    [[JXRequestManager sharedNetWorkManager] RequestListMallProductWithMallProductSearch:@"" Success:^(NSArray *mallProductArray) {
        for (NSDictionary *dic in mallProductArray) {
            ShopListModel *shopListModel = [ShopListModel objectWithKeyValues:dic];
            [self.dataArray addObject:shopListModel];
        }
        [self.collectionView reloadData];
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
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ShopListCollectionView forIndexPath:indexPath];
    ShopListModel *shopListModel = [self.dataArray objectAtIndex:indexPath.row];
    cell.shopListModel = shopListModel;
    cell.backgroundColor = BackGroundColor;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopListModel *shopListModel = [self.dataArray objectAtIndex:indexPath.row];
    SingleGoodsViewController *shopDetail = [[SingleGoodsViewController alloc] init];
    shopDetail.idString = shopListModel.id;
    [self.navigationController pushViewController:shopDetail animated:YES];
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.itemSize = CGSizeMake(Screen_Width() / 2- 2.5 , Screen_Width() / 2 + 72);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 44,Screen_Width(),Screen_Height() - 64 - 44) collectionViewLayout:flowLayout];
        
        [_collectionView registerClass:[ShopListCollectionViewCell class] forCellWithReuseIdentifier:ShopListCollectionView];
        _collectionView.delegate = self;
        _collectionView.dataSource  = self;
        _collectionView.backgroundColor = BackGroundColor;
        
        //设置头或者尾部
        [_collectionView registerClass:[ShopHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kfooterIdentifier];
    }
    return  _collectionView;
}


-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
