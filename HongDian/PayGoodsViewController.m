

//
//  PayGoodsViewController.m
//  HongDian
//
//  Created by 姜通 on 15/7/21.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "PayGoodsViewController.h"
#import "Config.h"
#import "WXApi.h"
#import "CommonUtil.h"
#import <Masonry/Masonry.h>
#import "PayGoodsTableViewCell.h"
#import "SelectAddressViewController.h"
#import "JXRequestManager.h"
#import <CommonCrypto/CommonDigest.h>
#import <AlipaySDK/AlipaySDK.h>
#import "PayTypeView.h"


@interface PayGoodsViewController ()

@end

@implementation PayGoodsViewController

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == self) {
        self.navigationController.navigationBar.alpha = 1;
    } else {
        self.navigationController.navigationBar.alpha =0;
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"确认下单";
    [self addHeaderview];
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 100)];
    self.headView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addHeaderview{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 100)];
    view.backgroundColor = [UIColor colorWithRed:92/255.0 green:202/255.0 blue:188/255.0 alpha:1.0];
    [self.view addSubview:view];
    view.userInteractionEnabled = YES;
    
    UILabel *peopleLabel = [[UILabel alloc] init];
    peopleLabel.text = [NSString stringWithFormat:@"收货人：%@         %@",@"xxxxx",@"188xxxxxxx"];
    [view addSubview:peopleLabel];
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.text = [NSString stringWithFormat:@"收货地址：%@",@"xxxxx"];
    [view addSubview:addressLabel];
    
    [peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@20);
        make.right.equalTo(@20);
    }];
    
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(peopleLabel.mas_bottom).offset(10);
        make.right.equalTo(@20);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeYourAddress:)];
    [view addGestureRecognizer:tap];
}

#pragma mark - 选择地址
-(void)changeYourAddress:(UITapGestureRecognizer *)ger{
    SelectAddressViewController *selectAddress = [[SelectAddressViewController alloc] init];
    [self.navigationController pushViewController:selectAddress animated:YES];
}


#pragma mark - 微信支付
-(void)wechatpay{
    [[JXRequestManager sharedNetWorkManager] PayGoodsWithPaymentChannel:JXC_OM_SALE_ORDER_PAYMENT_CHANNEL_KEY_WECHATPAY andomSaleOrderHeaderId:self.omSaleOrderHeaderId Success:^(NSDictionary *orderDic) {
        NSString *nonceStr = [orderDic objectForKey:@"noncestr"];
        NSString *package = [orderDic objectForKey:@"package"];
        NSString *prepayId = [orderDic objectForKey:@"prepayid"];
        NSString *sign = [orderDic objectForKey:@"sign"];
        NSString *timeStamp = [orderDic objectForKey:@"timestamp"];
        NSString *partnerId = [orderDic objectForKey:@"partnerid"];

        PayReq *request = [[PayReq alloc]init];
        request.partnerId = partnerId;
        request.prepayId = prepayId;
        request.package = package;
        request.nonceStr = nonceStr;
        request.timeStamp = [timeStamp intValue];
        request.sign = sign;

        [[NSUserDefaults standardUserDefaults] setObject:self.omSaleOrderHeaderId forKey:out_trade_no];
        [WXApi sendReq:request];
    } failture:^(NSString *errMsg) {
        
    }];
}

-(void)aliPay{
  [[JXRequestManager sharedNetWorkManager] PayGoodsWithAliPayPaymentChannel:JXC_OM_SALE_ORDER_PAYMENT_CHANNEL_KEY_ALIPAY andomSaleOrderHeaderId:self.omSaleOrderHeaderId Success:^(NSDictionary *alipayDic) {
      NSString *appScheme = kJXAPPScheme;
      NSString *orderString = [alipayDic objectForKey:@"message"];
      WS(weakSelf);
      [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
          {
              NSString *resultStatus = resultDic[@"resultStatus"];
              NSString *message = resultDic[@"memo"];
              NSString *resultStr = resultDic[@"result"];
              UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"支付成功，请前往个人中心查看订单信息" delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil];
              alertView.tag = 100;
              if ([resultStatus isEqualToString:@"9000"] && [resultStr rangeOfString:@"success=\"true\""].length > 0) {
                  [alertView show];
              } else if([resultStatus isEqualToString:@"9000"]) {
                  [self OrderToSureTheSuccessAliPay];
              } else{
                  alertView.message = message;
                  [alertView show];
              }
          }
        }];
    } failture:^(NSString *errMsg) {
      NSLog(@" errMsg == =   %@",errMsg);
    }];
}

#pragma mark - 确定支付宝支付成功的回调
-(void)OrderToSureTheSuccessAliPay{
    NSString *outTradeNo = [[NSUserDefaults standardUserDefaults] objectForKey:out_trade_no];
    [[JXRequestManager sharedNetWorkManager] AliPayGoodsWithOmSaleOrderHeaderId:outTradeNo Success:^(NSDictionary *orderDic) {
        NSString *basePaymentStatusKey = [orderDic objectForKey:@"basePaymentStatusKey"];
        if ([basePaymentStatusKey isEqualToString:@"20"]) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"支付成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
    } failture:^(NSString *errMsg) {
    }];
}


#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    else return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 130;
        } else if (indexPath.row==1){
            return 40;
        } else if (indexPath.row == 2) {
            return 40;
        }
    } else if (indexPath.section == 1){
        return 60;
    }
    return 60;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        PayTypeView *typeView = [[PayTypeView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 200)];
        WS(weakSelf);
        
        typeView.wechatPayBlock = ^(){
            [weakSelf wechatpay];
        };
        
        typeView.aliPayBlock = ^(){
            [weakSelf aliPay];
        };
        return typeView;
    }
    else return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    } else if (section == 1) {
        return 200;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *identifier = @"PayGoodsTableViewCell";
            PayGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell =  [[PayGoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
             }
            cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
            cell.layer.borderWidth = 1;
            return cell;
        } else if (indexPath.row == 1) {
            static NSString *identifier = @"identifierone";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
            cell.layer.borderWidth = 1;
            UILabel *label = [[UILabel alloc] init];
            label.text = @"配送方式";
            [cell addSubview:label];
            UILabel *moneyLable = [[UILabel alloc] init];
            moneyLable.text = @"快递 免邮";
            [cell addSubview:label];
            [cell addSubview:moneyLable];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@10);
                make.centerY.equalTo(cell.mas_centerY);
            }];
            
            [moneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(@-10);
                make.centerY.equalTo(cell.mas_centerY);
            }];
            return cell;
        } else if (indexPath.row == 2) {
            static NSString *identifier = @"identifiertwo";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
            cell.layer.borderWidth = 1;
            UILabel *label = [[UILabel alloc] init];
            label.text = @"合计";
            [cell addSubview:label];
            UILabel *moneyLable = [[UILabel alloc] init];
            moneyLable.text = @"xxxxxx";
            [cell addSubview:label];
            [cell addSubview:moneyLable];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@10);
                make.centerY.equalTo(cell.mas_centerY);
            }];
            [moneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(@-10);
                make.centerY.equalTo(cell.mas_centerY);
            }];
            return cell;
        }
    } else if (indexPath.section ==1) {
        static NSString *identifier = @"identifierthree";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.layer.borderWidth = 2;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 180, 40)];
        label.text = @"实付金额: 1800";
        label.textColor = [UIColor redColor];
        [cell addSubview:label];
        
        UILabel *label2 = [[UILabel alloc] init];
        label2.text = @"使用优惠券";
        label2.textColor = [UIColor redColor];
        [cell addSubview:label2];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"check_noselect"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"check_select"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(userDiscount:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button];
        
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.centerY.equalTo(cell.mas_centerY);
        }];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(label2.mas_left).offset(-10);
            make.centerY.equalTo(cell.mas_centerY);
            make.width.equalTo(@30);
            make.height.equalTo(@30);
        }];
        return cell;
    }
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}

#pragma mark -选择是否使用优惠券
-(void)userDiscount:(UIButton *)btn {
    btn.selected = !btn.selected;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100,Screen_Width(), Screen_Height() - 100 - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.sectionHeaderHeight = 5;
//        _tableView.tableHeaderView= self.headView;
        _tableView.sectionFooterHeight = 0;
    }
    return _tableView;
}


@end
