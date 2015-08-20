//
//  MyVouponViewController.h
//  HongDian
//
//  Created by 姜通 on 15/8/14.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BaseViewController.h"
#import "ProfileLikeHeaderView.h"

@interface MyVouponViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>

@property (nonatomic, retain) UITableView *myOrderTableView;
@property (nonatomic, retain) ProfileLikeHeaderView *profileLikeHeaderView;
@property (nonatomic, retain) NSMutableArray *couponArray;

@end
