//
//  ProfileLikeViewController.h
//  HongDian
//
//  Created by 姜通 on 15/8/12.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BaseViewController.h"
#import "ProfileLikeHeaderView.h"


@interface ProfileLikeViewController : BaseViewController<UINavigationControllerDelegate,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) UICollectionView *mycollectionView;

@property (nonatomic, retain) ProfileLikeHeaderView *profileHeaderView;
@property (nonatomic, retain) NSMutableArray *dataArray;

@end
