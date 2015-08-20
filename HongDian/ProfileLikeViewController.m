


//
//  ProfileLikeViewController.m
//  HongDian
//
//  Created by 姜通 on 15/8/12.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "ProfileLikeViewController.h"
#import "ShopListCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "Config.h"
#import "MyOrderTableViewCell.h"
#import "MyOrderHeadView.h"
#import "OrderDetailViewController.h"
#import "MyOrderViewController.h"
#import "ProfileCollectionReusableView.h"
#import "MyVouponViewController.h"
#import "JXRequestManager.h"
#import "ShopListModel.h"
#import <MJExtension/MJExtension.h>
#import "ProfileLikeModel.h"
#import "SingleGoodsViewController.h"
#import "AnotherMoreViewController.h"


#define ShopListCollectionView @"ShopListCollectionViewCell"
static NSString *kheaderIdentifier = @"ProfileheaderIdentifier";
static NSString *kfooterIdentifier = @"ProfilefootIdentifier";
static NSString *kGoodsPropertyCollectionViewCellID = @"kGoodsPropertyCollectionViewCellID_";
static NSString *kGoodsNumberPropertyCollectionViewCellID = @"kGoodsNumberPropertyCollectionViewCellID";

@interface ProfileLikeViewController ()

@end

@implementation ProfileLikeViewController

//-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    if (viewController == self) {
//        self.navigationController.navigationBar.alpha = 0;
//    } else {
//        self.navigationController.navigationBar.alpha =1;
//    }
//}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    
    [[JXRequestManager sharedNetWorkManager] ListCrmUserLikeMallProductSuccess:^(NSArray *orderArray) {
        for (NSDictionary *dic in orderArray) {
            ProfileLikeModel *shopListModel = [ProfileLikeModel objectWithKeyValues:dic];
            [self.dataArray addObject:shopListModel];
        }
        [self.mycollectionView reloadData];
    } failture:^(NSString *errMsg) {
        
    }];
    [self.view addSubview:self.mycollectionView];
}


-(void)changeTheTypeOfTheViewWithTag:(NSInteger)tag{
    if (tag == 101) {
        MyVouponViewController *MyVouponVC = [[MyVouponViewController alloc] init];
        NSMutableArray *viewControllers = [self.navigationController.viewControllers mutableCopy];
        [viewControllers removeLastObject];
        [viewControllers addObject:MyVouponVC];
        [self.navigationController setViewControllers:viewControllers animated:NO];
    } else if (tag == 100) {
        return;
    } else if (tag == 102) {
        MyOrderViewController *myOrderVC = [[MyOrderViewController alloc] init];
        NSMutableArray *viewControllers = [self.navigationController.viewControllers mutableCopy];
        [viewControllers removeLastObject];
        [viewControllers addObject:myOrderVC];
        [self.navigationController setViewControllers:viewControllers animated:NO];
    }
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(Screen_Width(), 252);
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]){
        reuseIdentifier = kheaderIdentifier;
        WS(weakSelf);
        ProfileCollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
        view.changethetypeBlock = ^(NSInteger tag,UIButton *btn){
            [weakSelf changeTheTypeOfTheViewWithTag:tag];
        };
        
        view.backToMainVcBlock = ^(){
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        
        view.gotobackVcBlock = ^(){
            AnotherMoreViewController *anotherVC = [[AnotherMoreViewController alloc] init];
            [self.navigationController pushViewController:anotherVC animated:YES];
        };
        return view;
    } else {
        reuseIdentifier = kfooterIdentifier;
        UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind: kind withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
        return view;
    }
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
    ProfileLikeModel *profileModel = self.dataArray[indexPath.row];
    NSDictionary *dic = profileModel.mallProduct;
    ShopListModel *model = [ShopListModel objectWithKeyValues:dic];
    cell.shopListModel = model;
//    cell.backgroundColor = BackGroundColor;
    return cell;
}

-(void)lookAllGoods{
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SingleGoodsViewController *shopDetail = [[SingleGoodsViewController alloc] init];    
    ProfileLikeModel *profileModel = self.dataArray[indexPath.row];
    NSDictionary *dic = profileModel.mallProduct;
    ShopListModel *model = [ShopListModel objectWithKeyValues:dic];
    shopDetail.idString = model.id;
    [self.navigationController pushViewController:shopDetail animated:YES];
}

-(UICollectionView *)mycollectionView
{
    if (!_mycollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.itemSize = CGSizeMake(Screen_Width() / 2- 2.5 , Screen_Width() / 2 + 72);
        flowLayout.headerReferenceSize = CGSizeMake(Screen_Width(), 252);
        _mycollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,Screen_Height()) collectionViewLayout:flowLayout];
        [_mycollectionView registerClass:[ShopListCollectionViewCell class] forCellWithReuseIdentifier:ShopListCollectionView];
        _mycollectionView.delegate = self;
        _mycollectionView.dataSource  = self;
        _mycollectionView.backgroundColor = BackGroundColor;
        [_mycollectionView registerClass:[ProfileCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
    }
    return  _mycollectionView;
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
