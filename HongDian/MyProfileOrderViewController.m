

//
//  MyProfileOrderViewController.m
//  HongDian
//
//  Created by 姜通 on 15/8/18.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "MyProfileOrderViewController.h"
#import "Config.h"
#import "MyOrderTableViewCell.h"
#import "SelectAddressViewController.h"
#import <Masonry/Masonry.h>
#import "PayTypeViewController.h"
#import "BuyCarModel.h"
#import "JXRequestManager.h"
#import <MJExtension/MJExtension.h>
#import "AddressModel.h"
#import "PayModel.h"
#import "MyProfileOrderModel.h"
#import "MyProfileCellModel.h"
#import "MyProfileOrderDetailTableViewCell.h"
#import "MyProfileOrderHeaderView.h"
#import "MyProfileFooterView.h"


@interface MyProfileOrderViewController ()
@property (nonatomic, retain) MyProfileOrderModel *myProfileModel;
@property (nonatomic, retain) MyProfileOrderHeaderView *myProfileOrderHeaderView;
@property (nonatomic, retain) MyProfileFooterView *myProfileFooterView;

@end

@implementation MyProfileOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"订单详情";
    [self.view addSubview:self.tableView];
    
    [[JXRequestManager sharedNetWorkManager] ViewOmSaleOrderWithOrderIdString:self.idString Success:^(NSDictionary *orderDic) {
        self.myProfileModel = [MyProfileOrderModel objectWithKeyValues:orderDic];
        NSArray *array = self.myProfileModel.omSaleOrderDetail;
        for (NSDictionary *dic in array) {
            MyProfileCellModel *model = [MyProfileCellModel objectWithKeyValues:dic];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
    } failture:^(NSString *errMsg) {
        
    }];
 }

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idenifier";
    MyProfileOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MyProfileOrderDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.profileCellModel = self.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 100)];
    self.myProfileOrderHeaderView = [[MyProfileOrderHeaderView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 100)];
    self.myProfileOrderHeaderView.myProfileOrderModel = self.myProfileModel;
    [view addSubview:self.myProfileOrderHeaderView];
    
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 320 + 100)];
    self.myProfileFooterView = [[MyProfileFooterView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 320 + 100)];
    self.myProfileFooterView.myProfileOrderModel = self.myProfileModel;
    [view addSubview:self.myProfileFooterView];
    
    return view;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 320 + 50;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), Screen_Height() - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.tableFooterView = self.myProfileFooterView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
