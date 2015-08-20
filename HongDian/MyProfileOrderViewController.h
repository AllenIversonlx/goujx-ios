//
//  MyProfileOrderViewController.h
//  HongDian
//
//  Created by 姜通 on 15/8/18.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BaseViewController.h"


@interface MyProfileOrderViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSString *idString;
@property (nonatomic, retain) NSMutableArray *dataArray;
@end


