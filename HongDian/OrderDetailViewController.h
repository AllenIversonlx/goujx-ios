//
//  OrderDetailViewController.h
//  HongDian
//
//  Created by 姜通 on 15/8/4.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderModel.h"
#import "OrderDetailHeadView.h"
#import "OrderDetailFootView.h"
#import "AddressModel.h"
#import "PayModel.h"


@interface OrderDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,PayTheGoodsDelegate>

@property (nonatomic, retain) OrderModel *orderModel;
@property (nonatomic, retain) NSString *addressString;
@property (nonatomic, retain) NSString *addressIdString;
@property (nonatomic, retain) NSString *couponIdString;

@property (nonatomic, retain) NSString *payString;
@property (nonatomic, retain) NSMutableArray *selectGoodArray;
@property (nonatomic, assign) float totalFees;
@property (nonatomic, retain) NSArray *goodsArray;
@property (nonatomic, retain) NSDictionary *dic;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) OrderDetailHeadView *orderDetailHeadView;
@property (nonatomic, retain) OrderDetailFootView *orderDetailFootView;
@property (nonatomic, retain) AddressModel *adressModel;
@property (nonatomic, retain) UIImageView *payImageView;

@end
