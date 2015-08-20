

//
//  OrderDetailViewController.m
//  HongDian
//
//  Created by 姜通 on 15/8/4.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "Config.h"
#import "MyOrderTableViewCell.h"
#import "SelectAddressViewController.h"
#import <Masonry/Masonry.h>
#import "PayTypeViewController.h"
#import "BuyCarModel.h"
#import "JXRequestManager.h"
#import <MJExtension/MJExtension.h>
#import "AddressModel.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "PayModel.h"
#import "Toast+UIView.h"
#import "CouponViewController.h"

static NSString *kGoodsToBuyTableCellID = @"kGoodsToBuyTableCellID";

@interface OrderDetailViewController ()

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"订单详情";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), Screen_Height() - 64 ) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goodsArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 636;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 100)];
     self.orderDetailHeadView = [[OrderDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 100) andWithMoney:[NSString stringWithFormat:@"%.2f",self.totalFees] andOrderNumber:@"" andStatus:@"1"];
    [view addSubview:self.orderDetailHeadView];
    
    return view;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kGoodsToBuyTableCellID];
    if (cell == nil) {
        cell = [[MyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kGoodsToBuyTableCellID];
    }
    BuyCarModel *buyCarModel = [self.goodsArray objectAtIndex:indexPath.row];
    [cell applyModelValueWithModel:buyCarModel andCount:1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 636)];
    [view addSubview:self.orderDetailFootView];
    return view;
}

#pragma mark - 付款
-(void)PayTheGoods{
    for (int i = 0; i < self.goodsArray.count; i++) {
         BuyCarModel *model = self.goodsArray[i];
//        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
//                             [model.mallProductSku objectForKey:@"id"],@"mallProductSkuId",
//                             model.quantity,@"quantity",
//                             [[model.mallProductSku objectForKey:@"mallProduct"] objectForKey:@"salePrice"],@"price",
//                             nil];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             [model.mallProductSku objectForKey:@"id"],@"mallProductSkuId",
                             model.quantity,@"quantity",
                             @"0.01",@"price",
                             nil];
        [self.selectGoodArray addObject:dic];
    }

    if (!self.addressIdString) {
        [[self view] makeToast:@"请输入地址" duration:1 position:@"bottom"];
        return;
    }

    if (!self.couponIdString) {
        self.couponIdString = @"";
    }
    WS(weakSelf);
    [[JXRequestManager sharedNetWorkManager] createOmSaleOrderWithAddressIdString:self.addressIdString andCoupon:self.couponIdString mallArray:self.selectGoodArray Success:^(NSDictionary *omSaleDic) {
        NSString *idString = [omSaleDic objectForKey:@"id"];
        if ([self.payString isEqualToString:@"支付宝支付"]) {
            [weakSelf aliPayWithId:idString];
        } else if ([self.payString isEqualToString:@"微信支付"]){
            [self wechatpayWithId:idString];
        }
    } failture:^(NSString *errMsg) {
        [[self view] makeToast:@"下单失败" duration:1 position:@"bottom"];
    }];
}

#pragma mark - 微信支付
-(void)wechatpayWithId:(NSString *)idString{
    [[JXRequestManager sharedNetWorkManager] PayGoodsWithPaymentChannel:JXC_OM_SALE_ORDER_PAYMENT_CHANNEL_KEY_WECHATPAY andomSaleOrderHeaderId:idString Success:^(NSDictionary *orderDic) {
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
        
        [[NSUserDefaults standardUserDefaults] setObject:idString forKey:out_trade_no];
        [WXApi sendReq:request];
    } failture:^(NSString *errMsg) {
        [[self view] makeToast:@"支付失败" duration:1 position:@"bottom"];
    }];
}

-(void)aliPayWithId:(NSString *)idString{
    [[JXRequestManager sharedNetWorkManager] PayGoodsWithAliPayPaymentChannel:JXC_OM_SALE_ORDER_PAYMENT_CHANNEL_KEY_ALIPAY andomSaleOrderHeaderId:idString Success:^(NSDictionary *alipayDic) {
        NSString *appScheme = kJXAPPScheme;
        NSString *orderString = [alipayDic objectForKey:@"data"];
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

-(OrderDetailFootView *)orderDetailFootView
{
    if (!_orderDetailFootView) {
        WS(weakSelf);
        NSDictionary *dic = @{@"shippingToName":@"",@"shippingToPhone":@"",@"address":@"",@"isDefault":@"1",@"id":@"1",@"pay":@"1"};
        NSDictionary *payDic = @{@"name":@"支付宝支付",@"image":@"alipay_icon"};
        AddressModel *model = [AddressModel objectWithKeyValues:dic];
        PayModel *payModel = [PayModel objectWithKeyValues:payDic];
        _orderDetailFootView = [[OrderDetailFootView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 636)];
        
        _orderDetailFootView.addressModel = model;
        _orderDetailFootView.payModel = payModel;
        
        weakSelf.addressString = [NSString stringWithFormat:@"%@%@%@",model.shippingToName,model.shippingToPhone,model.address];
        
        weakSelf.payString = [NSString stringWithFormat:@"%@",payModel.name];
        _orderDetailFootView.backgroundColor = [UIColor whiteColor];
#pragma mark - 选择地址
        _orderDetailFootView.selectAddressType = ^() {
            SelectAddressViewController *selectVC = [[SelectAddressViewController alloc] init];
            selectVC.selectTheAddressBlock = ^(AddressModel *model){
                weakSelf.orderDetailFootView.addressModel = model;
                weakSelf.addressString = [NSString stringWithFormat:@"%@%@%@",model.shippingToName,model.shippingToPhone,model.address];
                weakSelf.addressIdString = model.id;
//                [weakSelf.orderDetailFootView setNeedsDisplay];
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:selectVC animated:YES];
        };
        
#pragma mark - 选择支付方式
        _orderDetailFootView.selectPayType = ^(){
            PayTypeViewController *payVC = [[PayTypeViewController alloc] init];
            payVC.selectblock = ^(PayModel *model){
                weakSelf.orderDetailFootView.payModel = model;
                weakSelf.payString = [NSString stringWithFormat:@"%@",model.name];
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:payVC animated:YES];
        };
#pragma mark - 去付款
        _orderDetailFootView.payTheGoodBlock = ^(){
            [weakSelf PayTheGoods];
        };
#pragma mark - 去购物券
        _orderDetailFootView.selectTheCouponTypeBlock = ^(){
            CouponViewController *coupon = [[CouponViewController alloc] init];
            coupon.selectCouponBlock = ^(CouponModel *model){
                weakSelf.orderDetailFootView.couponModel = model;
                weakSelf.couponIdString = model.id;
                [weakSelf.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:coupon animated:YES];
        };
    }
    return _orderDetailFootView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)selectGoodArray
{
    if (!_selectGoodArray) {
        _selectGoodArray = [NSMutableArray array];
    }
    return _selectGoodArray;
}




@end
