//
//  ShopListViewController.h
//  HongDian
//
//  Created by 姜通 on 15/8/18.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BaseViewController.h"
#import "Config.h"
#import <MJRefresh/MJRefresh.h>
#import <MJExtension/MJExtension.h>
#import <Masonry/Masonry.h>
#import "SingleGoodsViewController.h"
#import "JXRequestManager.h"
#import "ShopListCollectionViewCell.h"
#import "Config.h"
#import <Masonry/Masonry.h>
#import "ShopHeaderCollectionReusableView.h"
#import "JXRequestManager.h"
#import "ShopDetailViewController.h"

@interface ShopListViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate>

@property (nonatomic, retain) UICollectionView *collectionView;

@property (nonatomic, strong) NSString *integerString;
@property (nonatomic, retain) NSMutableArray *dataArray;

@property (nonatomic, retain) NSString *refreshUrl;
@property (nonatomic, retain) NSMutableArray *titleArray;

@end
