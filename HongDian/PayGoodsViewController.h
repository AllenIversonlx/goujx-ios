//
//  PayGoodsViewController.h
//  HongDian
//
//  Created by 姜通 on 15/7/21.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BaseViewController.h"

@interface PayGoodsViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>
@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) UIView *headView;

@property (nonatomic, copy) NSString *omSaleOrderHeaderId;
@end
