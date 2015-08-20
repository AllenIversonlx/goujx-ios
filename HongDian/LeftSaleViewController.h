//
//  LeftSaleViewController.h
//  HongDian
//
//  Created by 姜通 on 15/7/9.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
@interface LeftSaleViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSArray *array;

@end
