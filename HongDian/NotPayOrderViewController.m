




//
//  NotPayOrderViewController.m
//  HongDian
//
//  Created by 姜通 on 15/8/19.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "NotPayOrderViewController.h"
#import "Config.h"
#import "Toast+UIView.h"
#import "PayModel.h"
#import "CouponModel.h"
#import "MyOrderTableViewCell.h"
#import "SelectAddressViewController.h"
#import <Masonry/Masonry.h>
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
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
#import "OrderDetailFootView.h"
#import "CouponViewController.h"
#import "CouponModel.h"

@interface NotPayOrderViewController ()
@property (nonatomic, retain) MyProfileOrderModel *myProfileModel;
@property (nonatomic, retain) MyProfileOrderHeaderView *myProfileOrderHeaderView;
@property (nonatomic, retain) MyProfileFooterView *myProfileFooterView;
@property (nonatomic, retain) OrderDetailFootView *orderDetailFootView;

@end

@implementation NotPayOrderViewController

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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(),  636)];
    WS(weakSelf);
    NSDictionary *dic = [self.myProfileModel.wmsShipmentHeader objectAtIndex:0];
    NSDictionary *addressDic = [dic objectForKey:@"wmsShippingAddress"];
    NSString *omSaleOrderPaymentChannel = [self.myProfileModel.omSaleOrderPayment objectForKey:@"omSaleOrderPaymentChannel"];
    NSString *payString = @"";
    NSString *imageString =@"";
    if (omSaleOrderPaymentChannel) {
        if ([omSaleOrderPaymentChannel isEqualToString:@"微信支付"]) {
            payString = @"微信支付";
            imageString = @"wechat_L";
        } else if ([omSaleOrderPaymentChannel isEqualToString:@"支付宝支付"]) {
            payString = @"支付宝支付";
            imageString = @"alipay_icon";
        }
    }
    NSDictionary *payDic = @{@"name":payString,@"image":imageString};
    AddressModel *model = [AddressModel objectWithKeyValues:addressDic];
    PayModel *payModel = [PayModel objectWithKeyValues:payDic];
    self.orderDetailFootView = [[OrderDetailFootView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 636)];
    
    self.orderDetailFootView.addressModel = model;
    self.orderDetailFootView.payModel = payModel;
    
    self.orderDetailFootView.backgroundColor = [UIColor whiteColor];
#pragma mark - 选择地址
    self.orderDetailFootView.selectAddressType = ^() {
        SelectAddressViewController *selectVC = [[SelectAddressViewController alloc] init];
        selectVC.selectTheAddressBlock = ^(AddressModel *model){
            weakSelf.orderDetailFootView.addressModel = model;
            weakSelf.addressString = [NSString stringWithFormat:@"%@%@%@",model.shippingToName,model.shippingToPhone,model.address];
            weakSelf.addressIdString = model.id;
            
            [[JXRequestManager sharedNetWorkManager] OmSaleOrderSetShippingAddressId:model.id omSaleOrderHeaderId:weakSelf.myProfileModel.id Success:^(NSArray *orderArray) {
                [[weakSelf view] makeToast:@"更改地址成功" duration:1 position:@"bottom"];
            } failture:^(NSString *errMsg) {
                
            }];
            
            [weakSelf.orderDetailFootView setNeedsDisplay];
        };
        [weakSelf.navigationController pushViewController:selectVC animated:YES];
    };
    weakSelf.payString = [NSString stringWithFormat:@"%@",payModel.name];

#pragma mark - 选择支付方式
    self.orderDetailFootView.selectPayType = ^(){
        PayTypeViewController *payVC = [[PayTypeViewController alloc] init];
        payVC.selectblock = ^(PayModel *model){
            weakSelf.orderDetailFootView.payModel = model;
            weakSelf.payString = [NSString stringWithFormat:@"%@",model.name];
            [weakSelf.orderDetailFootView setNeedsDisplay];
        };
        [weakSelf.navigationController pushViewController:payVC animated:YES];
    };
#pragma mark - 去付款
    self.orderDetailFootView.payTheGoodBlock = ^(){
        [weakSelf PayTheGoods];
    };
#pragma mark - 去购物券
    self.orderDetailFootView.selectTheCouponTypeBlock = ^(){
        CouponViewController *coupon = [[CouponViewController alloc] init];
        coupon.selectCouponBlock = ^(CouponModel *model){
            weakSelf.orderDetailFootView.couponModel = model;
            weakSelf.couponIdString = model.id;
            [[JXRequestManager sharedNetWorkManager] OmSaleOrderSetCrmCouponId:model.id omSaleOrderHeaderId:weakSelf.myProfileModel.id Success:^(NSArray *orderArray) {
                [[weakSelf view] makeToast:@"更改地址成功" duration:1 position:@"bottom"];
            } failture:^(NSString *errMsg) {
                
            }];
            
            [weakSelf.orderDetailFootView setNeedsDisplay];
        };
        [weakSelf.navigationController pushViewController:coupon animated:YES];
    };
    
#pragma mark - 取消订单
    self.orderDetailFootView.cancleBolck = ^(){
     [[JXRequestManager sharedNetWorkManager] CancelOmSaleOrderWithSaleOrderHeaderId:weakSelf.myProfileModel.id Success:^(NSDictionary *orderDic) {
         NSString *success = [orderDic objectForKey:@"success"];
         if ([success boolValue] == 1) {
             [[weakSelf  view] makeToast:@"取消订单成功" duration:1 position:@"bottom"];
         } else  {
             [[weakSelf  view] makeToast:@"取消订单成功" duration:1 position:@"bottom"];
         }
     } failture:^(NSString *errMsg) {
         [[weakSelf  view] makeToast:@"取消订单成功" duration:1 position:@"bottom"];
     }];
    };
    
    [view addSubview:self.orderDetailFootView];

    return view;
}

#pragma mark - 付款
-(void)PayTheGoods{
    WS(weakSelf);
    if ([weakSelf.payString isEqualToString:@"微信支付"]) {
        [weakSelf wechatpayWithId:weakSelf.myProfileModel.id];
    } else if ([weakSelf.payString isEqualToString:@"支付宝支付"]) {
        [weakSelf aliPayWithId:weakSelf.myProfileModel.id];
    }
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


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 636;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), Screen_Height() - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
