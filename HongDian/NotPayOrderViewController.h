//
//  NotPayOrderViewController.h
//  HongDian
//
//  Created by 姜通 on 15/8/19.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BaseViewController.h"

@interface NotPayOrderViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSString *idString;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) NSString *payString;
@property (nonatomic, retain) NSString *addressString;
@property (nonatomic, retain) NSString *addressIdString;
@property (nonatomic, retain) NSString *couponIdString;
@end
