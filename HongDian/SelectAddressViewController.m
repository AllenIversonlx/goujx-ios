

//
//  SelectAddressViewController.m
//  HongDian
//
//  Created by 姜通 on 15/7/22.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "SelectAddressViewController.h"
#import "Config.h"
#import "SelectTableViewCell.h"
#import "AddNewAddressViewController.h"
#import "UIButton+Utilis.h"
#import "JXRequestManager.h"
#import "AddressModel.h"
#import <MJExtension/MJExtension.h>
#import "Toast+UIView.h"

@interface SelectAddressViewController ()

@property (nonatomic, retain) NSMutableArray *cityArray;

@end

@implementation SelectAddressViewController



-(void)FirstTheUrl{
    [self.cityArray removeAllObjects];
    [[JXRequestManager sharedNetWorkManager] GetlistWmsShippingAddressSuccess:^(NSArray *dictrictArray) {
        for (NSDictionary *dic in dictrictArray) {
            AddressModel *addressModel = [AddressModel objectWithKeyValues:dic];
            [self.cityArray addObject:addressModel];
        }
        [self.tableView reloadData];
    } failture:^(NSString *errMsg) {
        [[self view] makeToast:@"获取地址信息失败" duration:1 position:@"bottom"];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"收货人信息";
    [self.view addSubview:self.tableView];
    [self FirstTheUrl];
    
    // Do any additional setup after loading the view.
}

-(void)AddNewAddress:(UIButton *)btn {
    WS(weakSelf);
    AddNewAddressViewController *addNew = [[AddNewAddressViewController alloc] init];
    addNew.contentTheAddressBlcok = ^(){
        [weakSelf FirstTheUrl];
    };
    [self.navigationController pushViewController:addNew animated:YES];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cityArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 119;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    SelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[SelectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    AddressModel *addressModel = [self.cityArray objectAtIndex:indexPath.row];
    cell.addressModel = addressModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WS(weakSelf);
    cell.selectAddressBlock = ^(UIButton *btn){
        [weakSelf tableCellButtonDidSelected:btn];
    };
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 95;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 95)];
    UIButton *button = [UIButton borderbuttonWithTitleString:@"添加收货地址" andWithColor:ButtonColor];
    [view addSubview:button];
    [button addTarget:self action:@selector(AddNewAddress:) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top).offset(35);
        make.height.equalTo(@60);
        make.left.equalTo(@25);
        make.right.equalTo(@-25);
    }];
    return view;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressModel *addressModel = [self.cityArray objectAtIndex:indexPath.row];
    if (self.selectTheAddressBlock) {
        self.selectTheAddressBlock(addressModel);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)tableCellButtonDidSelected:(UIButton *)button
{
    if (self.lastSelectedButton != nil) {
        self.lastSelectedButton.selected = NO;
    }
    self.lastSelectedButton = button;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,Screen_Width(), Screen_Height() - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        NSIndexPath *ip=[NSIndexPath indexPathForRow:0 inSection:0];
//        [_tableView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionBottom];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}


-(NSMutableArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
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
