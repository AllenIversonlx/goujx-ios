


//
//  PayTypeViewController.m
//  HongDian
//
//  Created by 姜通 on 15/8/13.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "PayTypeViewController.h"
#import "Config.h"
#import <Masonry/Masonry.h>
#import "PersonTableViewCell.h"
#import "UIButton+Utilis.h"
#import <MJExtension/MJExtension.h>

@interface PayTypeViewController ()

@end

@implementation PayTypeViewController


-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"支付方式";
    self.array = @[@{@"name":@"支付宝支付",@"image":@"alipay_icon"},@{@"name":@"微信支付",@"image":@"wechat_L"}];
    for (NSDictionary *dic in self.array) {
        PayModel *payModel = [PayModel objectWithKeyValues:dic];
        [self.dataArray addObject:payModel];
    }
    [self.view addSubview:self.tableView];

    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    PersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[PersonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    PayModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.payModel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PayModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if (self.selectblock) {
        self.selectblock(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), Screen_Height()) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


@end
