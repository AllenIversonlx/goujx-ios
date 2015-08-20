//
//  CouponViewController.h
//  HongDian
//
//  Created by 姜通 on 15/7/22.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BaseViewController.h"
#import "CouponModel.h"
typedef void(^SelectTheCouponBlock)(CouponModel *model);

@interface CouponViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, copy) SelectTheCouponBlock selectCouponBlock;
@end
