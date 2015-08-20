//
//  ShopSecondViewController.h
//  HongDian
//
//  Created by 姜通 on 15/8/7.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BaseViewController.h"
#import "ShopListView.h"
#import "Config.h"
#import <MJRefresh/MJRefresh.h>
#import <MJExtension/MJExtension.h>
#import <Masonry/Masonry.h>
#import "SingleGoodsViewController.h"

@interface ShopSecondViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) UICollectionView *collectionView;

@property (nonatomic, strong) NSString *integerString;
@property (nonatomic, retain) ShopListView *shopListView;
@property (nonatomic, retain) NSMutableArray *dataArray;

@property (nonatomic, retain) NSString *refreshUrl;

@end
