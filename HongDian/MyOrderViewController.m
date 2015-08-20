//
//  MyOrderViewController.m
//  HongDian
//
//  Created by 姜通 on 15/8/14.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "MyOrderViewController.h"
#import "Config.h"
#import "ProfileLikeHeaderView.h"
#import "MyOrderHeadView.h"
#import "OrderDetailViewController.h"
#import <Masonry/Masonry.h>
#import "ProfileLikeViewController.h"
#import "MyVouponViewController.h"
#import "JXRequestManager.h"
#import <MJExtension/MJExtension.h>
#import "HeadScrollView.h"
#import "MyOrderModel.h"
#import "ProfileOrderListTableViewCell.h"
#import "MyOrderOmSaleOrderModel.h"
#import "MyProfileOrderViewController.h"
#import "NotPayOrderViewController.h"
#import "AnotherMoreViewController.h"

#define AllOrderUrl  @"fields=id,documentNum,filingDate&expand=omSaleOrderHeaderStatus,basePaymentStatus,omSaleOrderDetail,displayStatus"

//未付款
#define NotPayTheGoodUrl  @"OmSaleOrderHeaderSearch[omSaleOrderHeaderStatusKey]=20&OmSaleOrderHeaderSearch[basePaymentStatusKey]=10"

//待发货
#define WaitForTheDeliveryUrl  @"OmSaleOrderHeaderSearch[omSaleOrderHeaderStatusKey]=20&OmSaleOrderHeaderSearch[basePaymentStatusKey]=20"

//已发货
#define TheShipmentsUrl  @"OmSaleOrderHeaderSearch[omSaleOrderHeaderStatusKey]=40&OmSaleOrderHeaderSearch[basePaymentStatusKey]=20"

//已取消
#define HaveCancleTheGoodUrl  @"OmSaleOrderHeaderSearch[omSaleOrderHeaderStatusKey]=90"

@interface MyOrderViewController ()

@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.myOrderTableView];

    [self LoadTheOrderStatus:@"1"];
}

#pragma mark - 获取第一次的信息 以及订单的状态
-(void)LoadTheOrderStatus:(NSString *)orderString{
    int order = [orderString intValue];
    NSString *orderStatusString = @"";
    switch (order) {
        case 1:
        {
            orderStatusString = AllOrderUrl;
            break;
        }
        case 2:{
            orderStatusString =  [NSString stringWithFormat:@"%@&%@",AllOrderUrl,NotPayTheGoodUrl];
            break;
        }
        case 3:{
            orderStatusString =  [NSString stringWithFormat:@"%@&%@",AllOrderUrl,WaitForTheDeliveryUrl];
            break;
        }
        case 4:{
            orderStatusString =  [NSString stringWithFormat:@"%@&%@",AllOrderUrl,TheShipmentsUrl];
            break;
        }
        case 5:{
            orderStatusString =  [NSString stringWithFormat:@"%@&%@",AllOrderUrl,HaveCancleTheGoodUrl];
            break;
        }
            
        default:
            break;
    }

    [self.orderArray removeAllObjects];
    [[JXRequestManager sharedNetWorkManager] ListOmSaleOrderWithOrderStatus:orderStatusString Success:^(NSArray *orderArray) {
        for (NSDictionary *dic in orderArray) {
            MyOrderModel *orderModel = [MyOrderModel objectWithKeyValues:dic];
            [self.orderArray addObject:orderModel];
        }
        [self.myOrderTableView reloadData];
    } failture:^(NSString *errMsg) {
        
    }];
}

-(void)changeTheTypeOfTheViewWithTag:(NSInteger)tag{
    if (tag == 100) {
        ProfileLikeViewController *myOrderVC = [[ProfileLikeViewController alloc] init];
        NSMutableArray *viewControllers = [self.navigationController.viewControllers mutableCopy];
        [viewControllers removeLastObject];
        [viewControllers addObject:myOrderVC];
        [self.navigationController setViewControllers:viewControllers animated:NO];
    } else if (tag == 101){
        MyVouponViewController *MyVouponVC = [[MyVouponViewController alloc] init];
        NSMutableArray *viewControllers = [self.navigationController.viewControllers mutableCopy];
        [viewControllers removeLastObject];
        [viewControllers addObject:MyVouponVC];
        [self.navigationController setViewControllers:viewControllers animated:NO];
    } else if (tag == 102) {
        return;
    }
}

#pragma mark - UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.orderArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MyOrderModel *myOrderModel = self.orderArray[section];
    NSArray *array = myOrderModel.omSaleOrderDetail;
    return array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"identifier";
    ProfileOrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[ProfileOrderListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    MyOrderModel *myOrderModel = self.orderArray[indexPath.section];
    NSArray *array = myOrderModel.omSaleOrderDetail;
    
    MyOrderOmSaleOrderModel *model = [MyOrderOmSaleOrderModel objectWithKeyValues:[array objectAtIndex:indexPath.row]];
    
    cell.myModel = model;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MyOrderModel *orderModel = self.orderArray[section];
    MyOrderHeadView *view = [[MyOrderHeadView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 60)];
    view.orderModel = orderModel;
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 60)];
    [button setTitle:@"订单详情" forState:UIControlStateNormal];
    button.titleLabel.font = LittleTextLabelFont;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(OrderDetail:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = section;
    button.backgroundColor = [UIColor whiteColor];
    return button;
}


#pragma mark - 订单详情
-(void)OrderDetail:(UIButton *)btn{
    MyOrderModel *orderModel = self.orderArray[btn.tag];
    if ([orderModel.displayStatus isEqualToString:@"待付款"]) {
        NotPayOrderViewController *orderVC = [[NotPayOrderViewController alloc] init];
        orderVC.idString = orderModel.id;
        [self.navigationController pushViewController:orderVC animated:YES];
    } else {
        MyProfileOrderViewController *myProfileOrder = [[MyProfileOrderViewController alloc] init];
        myProfileOrder.idString = orderModel.id;
        [self.navigationController pushViewController:myProfileOrder animated:YES];

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 懒加载
-(UITableView *)myOrderTableView
{
    if (!_myOrderTableView) {
        _myOrderTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, Screen_Width(), Screen_Height()) style:UITableViewStyleGrouped];
        _myOrderTableView.delegate = self;
        _myOrderTableView.dataSource = self;
        _myOrderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myOrderTableView.tableHeaderView = self.profileLikeHeaderView;
    }
    return _myOrderTableView;
}

-(NSMutableArray *)orderArray{
    if (!_orderArray) {
        _orderArray = [NSMutableArray array];
    }
    return _orderArray;
}

-(ProfileLikeHeaderView *)profileLikeHeaderView
{
    if (!_profileLikeHeaderView) {
        WS(weakSelf);
        _profileLikeHeaderView = [[ProfileLikeHeaderView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 252 + 44) andtag:@"102"];
        _profileLikeHeaderView.changethetypeBlock = ^(NSInteger tag,UIButton *btn){
            [weakSelf changeTheTypeOfTheViewWithTag:tag];
        };
       
        _profileLikeHeaderView.backToMainVcBlock = ^(){
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };

        _profileLikeHeaderView.selectThPayOrderBlock = ^(NSDictionary *dic){
            NSString *statusString = [dic objectForKey:@"id"];
            [weakSelf LoadTheOrderStatus:statusString];
        };
        
        _profileLikeHeaderView.gotobackVcBlock = ^(){
            AnotherMoreViewController *anotherVC = [[AnotherMoreViewController alloc] init];
            [weakSelf.navigationController pushViewController:anotherVC animated:YES];
        };
    }
    return _profileLikeHeaderView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    //    self.navigationController.delegate = self;
}

@end