//
//  SelectAddressViewController.h
//  HongDian
//
//  Created by 姜通 on 15/7/22.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressModel.h"
typedef void(^SelectTheAddressBlock)(AddressModel *model);

@interface SelectAddressViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, strong) UIButton *lastSelectedButton;

@property (nonatomic, copy) SelectTheAddressBlock selectTheAddressBlock;


@end
