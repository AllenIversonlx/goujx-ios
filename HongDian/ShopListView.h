//
//  ShopListView.h
//  HongDian
//
//  Created by 姜通 on 15/7/16.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TapTheCollectionViewCellBlock)(NSInteger tag);


@interface ShopListView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) UICollectionView *collectionView;

@property (nonatomic, copy) TapTheCollectionViewCellBlock tapCollectionCellBlock;

-(instancetype)initWithFrame:(CGRect)frame;


@end
