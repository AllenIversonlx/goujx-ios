//
//  ShopBuyCarViewController.h
//  HongDian
//
//  Created by 姜通 on 15/7/20.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BaseViewController.h"

@interface ShopBuyCarViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *goodsSizeArray;
@property (nonatomic, strong) NSArray *goodsColorArray;


@end
