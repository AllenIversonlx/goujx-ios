



//
//  MyVouponViewController.m
//  HongDian
//
//  Created by 姜通 on 15/8/14.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "MyVouponViewController.h"
#import "Config.h"
#import "ProfileLikeHeaderView.h"
#import "MyOrderTableViewCell.h"
#import "OrderDetailFootView.h"
#import "MyOrderHeadView.h"
#import "OrderDetailViewController.h"
#import <Masonry/Masonry.h>
#import "MyVouponTableViewCell.h"
#import "ProfileLikeViewController.h"
#import "MyOrderViewController.h"
#import "TitleModel.h"
#import "HeadScrollView.h"
#import "JXRequestManager.h"
#import "CouponModel.h"
#import <MJExtension/MJExtension.h>
#import "AnotherMoreViewController.h"


#define AllCouponUrl @"&fields=id,name,code,discount,expireTimestamp&expand=crmCouponStatus"
#define HasUsedUrl      @"&CrmCouponSearch[crmCouponStatusKey]=20"
#define NotHasUseUrl    @"&CrmCouponSearch[crmCouponStatusKey]=30"
#define StaleDatedUrl       @"&CrmCouponSearch[crmCouponStatusKey]=40"
//#define DestroyUrl          @"&CrmCouponSearch[crmCouponStatusKey]=90"


@interface MyVouponViewController ()

@end

@implementation MyVouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myOrderTableView];
    
    [self LoadTheCouponStatus:@"1"];
}


-(void)changeTheTypeOfTheViewWithTag:(NSInteger)tag{
    if (tag == 100) {
        ProfileLikeViewController *myProfileLikeVC = [[ProfileLikeViewController alloc] init];
        NSMutableArray *viewControllers = [self.navigationController.viewControllers mutableCopy];
        [viewControllers removeLastObject];
        [viewControllers addObject:myProfileLikeVC];
        [self.navigationController setViewControllers:viewControllers animated:NO];
    } else if (tag == 101){
        return;
    } else if (tag == 102) {
        MyOrderViewController *MyOrderVC = [[MyOrderViewController alloc] init];
        NSMutableArray *viewControllers = [self.navigationController.viewControllers mutableCopy];
        [viewControllers removeLastObject];
        [viewControllers addObject:MyOrderVC];
        [self.navigationController setViewControllers:viewControllers animated:NO];
    }
}

#pragma mark - UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.couponArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"identifier";
    MyVouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[MyVouponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    CouponModel *model = [self.couponArray objectAtIndex:indexPath.row];
    cell.couponModel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

#pragma mark - 获取第一次的信息 以及订单的状态
-(void)LoadTheCouponStatus:(NSString *)orderString{
    int order = [orderString intValue];
    NSString *orderStatusString = @"";
    switch (order) {
        case 1:
        {
            orderStatusString =  [NSString stringWithFormat:@"%@%@",AllCouponUrl,HasUsedUrl];
            break;
        }
        case 2:{
            orderStatusString =  [NSString stringWithFormat:@"%@%@",AllCouponUrl,NotHasUseUrl];
            break;
        }
        case 3:{
            orderStatusString =  [NSString stringWithFormat:@"%@%@",AllCouponUrl,StaleDatedUrl];
            break;
        }
        case 4:{
            orderStatusString = AllCouponUrl;
            break;
        }
        default:
            break;
    }
    
    [self.couponArray removeAllObjects];
    [[JXRequestManager sharedNetWorkManager] ListCrmCouponOrderStatus:orderStatusString Success:^(NSArray *orderArray) {
        for (NSDictionary *dic in orderArray) {
            CouponModel *couponModel = [CouponModel objectWithKeyValues:dic];
            [self.couponArray addObject:couponModel];
        }
        [self.myOrderTableView reloadData];
    } failture:^(NSString *errMsg) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 懒加载
-(UITableView *)myOrderTableView
{
    if (!_myOrderTableView) {
        _myOrderTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, Screen_Width(), Screen_Height()) style:UITableViewStylePlain];
        _myOrderTableView.delegate = self;
        _myOrderTableView.dataSource = self;
        _myOrderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myOrderTableView.tableHeaderView = self.profileLikeHeaderView;
    }
    return _myOrderTableView;
}

-(ProfileLikeHeaderView *)profileLikeHeaderView
{
    if (!_profileLikeHeaderView) {
        WS(weakSelf);
        _profileLikeHeaderView = [[ProfileLikeHeaderView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 252 + 44) andtag:@"101"];
        _profileLikeHeaderView.changethetypeBlock = ^(NSInteger tag,UIButton *btn){
            [weakSelf changeTheTypeOfTheViewWithTag:tag];
        };
        _profileLikeHeaderView.backToMainVcBlock = ^(){
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        _profileLikeHeaderView.selectTheCouponBlock = ^(NSDictionary *dic){
            NSString *statusString = [dic objectForKey:@"id"];
            [weakSelf LoadTheCouponStatus:statusString];
        };
        _profileLikeHeaderView.gotobackVcBlock = ^(){
            AnotherMoreViewController *anotherVC = [[AnotherMoreViewController alloc] init];
            [weakSelf.navigationController pushViewController:anotherVC animated:YES];
        };

    }
    return _profileLikeHeaderView;
}

-(NSMutableArray *)couponArray
{
    if (!_couponArray) {
        _couponArray = [NSMutableArray array];
    }
    return _couponArray;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    //    self.navigationController.delegate = self;
}

@end
