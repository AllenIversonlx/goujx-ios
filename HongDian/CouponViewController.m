//
//  CouponViewController.m
//  HongDian
//
//  Created by 姜通 on 15/7/22.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "CouponViewController.h"
#import <Masonry/Masonry.h>
#import "Config.h"
#import "JXRequestManager.h"
#import "CouponModel.h"
#import <MJExtension/MJExtension.h>
#import "MyVouponTableViewCell.h"
#define AllCouponUrl @"&fields=id,name,code,discount,expireTimestamp&expand=crmCouponStatus"
#define HasUsedUrl      @"&CrmCouponSearch[crmCouponStatusKey]=20"

@interface CouponViewController ()

@end

@implementation CouponViewController

-(void)couponMessage:(UIButton *)btn{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"使用代金券";

    [self.view addSubview:self.tableView];
    NSString *orderStatusString = @"";
    orderStatusString =  [NSString stringWithFormat:@"%@%@",AllCouponUrl,HasUsedUrl];

    [[JXRequestManager sharedNetWorkManager] ListCrmCouponOrderStatus:orderStatusString Success:^(NSArray *orderArray) {
        for (NSDictionary *dic in orderArray) {
            CouponModel *couponModel = [CouponModel objectWithKeyValues:dic];
            [self.dataArray addObject:couponModel];
        }
        [self.tableView reloadData];
    } failture:^(NSString *errMsg) {
        
    }];}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    MyVouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MyVouponTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.couponModel = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectCouponBlock) {
        self.selectCouponBlock(self.dataArray[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), Screen_Height() - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
