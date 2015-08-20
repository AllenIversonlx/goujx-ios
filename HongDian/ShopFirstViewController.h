//
//  ShopFirstViewController.h
//  HongDian
//
//  Created by 姜通 on 15/8/7.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BaseViewController.h"


@interface ShopFirstViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, strong) NSString *integerString;
@property (nonatomic, retain) NSMutableArray *dataArray;

@property (nonatomic, retain) NSString *refreshUrl;

@end
