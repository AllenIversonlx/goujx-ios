//
//  AnotherMoreViewController.h
//  HongDian
//
//  Created by 姜通 on 15/8/10.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BaseViewController.h"

@interface AnotherMoreViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *array;

@end
