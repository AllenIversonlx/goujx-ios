//
//  BuyCarViewController.h
//  HongDian
//
//  Created by 姜通 on 15/7/13.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BaseViewController.h"

@interface BuyCarViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, strong) UIButton *allCheckBtn;
@property (nonatomic, strong) UIView *toolBarView; //toobar
@property (nonatomic, strong) UILabel *lb_totalFees;
@property (nonatomic, strong) NSMutableArray *selectedGoodsArray;
@property (nonatomic, retain) NSMutableArray *goodsArray;

@end
