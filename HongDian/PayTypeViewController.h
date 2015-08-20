//
//  PayTypeViewController.h
//  HongDian
//
//  Created by 姜通 on 15/8/13.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BaseViewController.h"
#import "PayModel.h"
typedef void(^SelectThePayBlock)(PayModel *model);

@interface PayTypeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *array;

@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, copy) SelectThePayBlock selectblock;

@end
