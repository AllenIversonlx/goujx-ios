//
//  JXRequestManager.h
//  HongDian
//
//  Created by 姜通 on 15/7/28.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface JXRequestManager : AFHTTPSessionManager

+ (instancetype)sharedNetWorkManager;


/**
 *  登陆
 *
 *  @param mobileNo <#mobileNo description#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
- (void)requestLoadUserWithMobileNumber:(NSString *)mobileNo andpassword:(NSString *)pwd success:(void(^)(NSString *token))success failture:(void(^)(NSString *errMsg))failture;


/**
 *   发送验证码
 *
 *  @param mobileNo <#mobileNo description#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
- (void)SendMobileAuthTokenWithMobileNumber:(NSString *)mobileNo success:(void(^)(NSString *token))success failture:(void(^)(NSString *errMsg))failture;

/**
 *   修改密码
 *  < #newpwd description#>
 *  @param oldpwd <#oldpwd description#>
 *  @param newpwd  <#newpwd description#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)RegisterWithNewPwd:(NSString *)pwdNew pwdOld:(NSString *)pwdOld success:(void(^)(NSString *token))success failture:(void(^)(NSString *errMsg))failture;

/**
 *   上传Token
 *  < #newpwd description#>
 *  @param oldpwd <#oldpwd description#>
 *  @param newpwd  <#newpwd description#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)RegisterIosDeviceToken:(NSData *)dataString success:(void(^)(NSString *token))success failture:(void(^)(NSString *errMsg))failture;

/**
 *   更改头像
 *  < #newpwd description#>
 *  @param oldpwd <#oldpwd description#>
 *  @param newpwd  <#newpwd description#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)actionUpdateCrmUserImage:(UIImage*)image success:(void(^)(NSDictionary *successString))success failture:(void(^)(NSString *errMsg))failture;

/**
 *   更改昵称
 *  < #newpwd description#>
 *  @param oldpwd <#oldpwd description#>
 *  @param newpwd  <#newpwd description#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)actionUpdateCrmUserNickName:(NSString*)nickName success:(void(^)(NSDictionary *successString))success failture:(void(^)(NSString *errMsg))failture;


/**
 *   注册
 *  < #name description# >
 *  @param mobileNo <#mobileNo description#>
 *  @param pwd <#pwd description#>
  *  @param name <#name description#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)RegisterWithMobileNumber:(NSString *)mobileNo pwd:(NSString *)pwd name:(NSString *)name photoImahe:(UIImage *)image andAccessToken:(NSString *)token success:(void(^)(NSString *token))success failture:(void(^)(NSString *errMsg))failture;

/**
 *   获取个人信息
 *  < #name description# >
 *  @param mobileNo <#mobileNo description#>
 *  @param pwd <#pwd description#>
 *  @param name <#name description#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)GetPersonInformationsuccess:(void(^)(NSDictionary *dic))success failture:(void(^)(NSString *errMsg))failture;


/**
 *   首页数据
 *  < #name description# >
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)requestShopWithUrl:(NSString *)url MaimSaleAndSuccess:(void(^)(NSArray *items, NSDictionary *linksArray))success failture:(void(^)(NSString *errMsg))failture;

/**
 *   首页数据 获取单个商品
 *  < #name description# >
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)RequestViewMallProduceWithIdString:(NSString *)idString Success:(void(^)(NSDictionary *singledic)) success failture:(void(^)(NSString *errMsg))failture;

/* 
 *  首页详细列表数据
 *  < #name description# >
 *  @param mallSaleDetailId <#searching#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)RequestListMallProductWithMallProductSearch:(NSString *)searchString Success:(void(^)(NSArray *mallProductArray))success failture:(void(^)(NSString *errMsg))failture;

/*
 *  获取分类列表有多少种类
 *  < #name description# >
 *  @param mallSaleDetailId <#searching#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)RequestListMallProductClassSuccess:(void(^)(NSArray *mallProductArray))success failture:(void(^)(NSString *errMsg))failture;

/**
 *   首页详细
 *  < #name description# >
  *  @param idstring <#idstring#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)RequestShopDetailWithidString:(NSString *)idString Success:(void(^)(NSDictionary *singledic)) success failture:(void(^)(NSString *errMsg))failture;


/**
 *  创建订单
 *  < #name description# >
 *  @param mallSaleDetailId <#mallSaleDetailId#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)createOmSaleOrderWithAddressIdString:(NSString *)addressIdString andCoupon:(NSString *)coupon mallArray:(NSMutableArray *)array Success:(void(^)(NSDictionary *omSaleDic)) success failture:(void(^)(NSString *errMsg))failture;

/**
 *  加入购物车
 *  < #name description# >
 *  @param mallSaleDetailId <#mallSaleDetailId#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)AddToCartWithmallProductSkuId:(NSString *)mallProductSkuId andquantity:(NSString *)quantity Success:(void(^)(NSArray *orderArray))success failture:(void(^)(NSString *errMsg))failture;

/**
 *  查看购物车
 *  < #name description# >
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)RequestListCarSuccess:(void(^)(NSArray *orderArray))success failture:(void(^)(NSString *errMsg))failture;

/**
 *  删除一件商品
 *  < #name description# >
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)DeleteFromCarWithMallProductSkuId:(NSString *)mallProductSkuId andGoodsCount:(NSString *)goodsCount Success:(void(^)(NSArray *orderArray))success failture:(void(^)(NSString *errMsg))failture;


/**
 *  微信支付
 *  < #name description# >
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)PayGoodsWithPaymentChannel:(NSString *)paymentChannel andomSaleOrderHeaderId:(NSString *)omSaleOrderHeaderId Success:(void(^)(NSDictionary *orderDic))success failture:(void(^)(NSString *errMsg))failture;

/**
 *  支付宝支付
 *  < #name description# >
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)PayGoodsWithAliPayPaymentChannel:(NSString *)paymentChannel andomSaleOrderHeaderId:(NSString *)omSaleOrderHeaderId Success:(void(^)(NSDictionary *alipayDic))success failture:(void(^)(NSString *errMsg))failture;


/**
 *  微信支付回调用
 *  < #name description# >
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)WeChatPayGoodsWithOmSaleOrderHeaderId:(NSString *)omSaleOrderHeaderId Success:(void(^)(NSDictionary *orderDic))success failture:(void(^)(NSString *errMsg))failture;

/**
 *  微信支付回调用
 *  < #name description# >
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)AliPayGoodsWithOmSaleOrderHeaderId:(NSString *)omSaleOrderHeaderId Success:(void(^)(NSDictionary *orderDic))success failture:(void(^)(NSString *errMsg))failture;


/**
 *  获取订单
 *  < #name description# >
 *  @param mallSaleDetailId <#mallSaleDetailId#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)ListOmSaleOrderWithOrderStatus:(NSString *)statusStrig Success:(void(^)(NSArray *orderArray))success failture:(void(^)(NSString *errMsg))failture;

/**
 *  订单详情
 *  < #name description# >
 *  @param mallSaleDetailId <#mallSaleDetailId#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)ViewOmSaleOrderWithOrderIdString:(NSString *)idstring Success:(void(^)(NSDictionary *orderDic))success failture:(void(^)(NSString *errMsg))failture;

/**
 *  取消订单
 *  < #name description# >
 *  @param mallSaleDetailId <#mallSaleDetailId#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)CancelOmSaleOrderWithSaleOrderHeaderId:(NSString *)SaleOrderHeaderId Success:(void(^)(NSDictionary *orderDic))success failture:(void(^)(NSString *errMsg))failture;

/**
 *  获取优惠券
 *  < #name description# >
 *  @param mallSaleDetailId <#mallSaleDetailId#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)ListCrmCouponOrderStatus:(NSString *)statusStrig Success:(void(^)(NSArray *orderArray))success failture:(void(^)(NSString *errMsg))failture;


/**
 *  更改地址
 *  < #name description# >
 *  @param mallSaleDetailId <#mallSaleDetailId#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)OmSaleOrderSetShippingAddressId:(NSString *)addressId  omSaleOrderHeaderId:(NSString *)omSaleOrderHeaderId Success:(void(^)(NSArray *orderArray))success failture:(void(^)(NSString *errMsg))failture;

/**
 *  喜欢产品
 *  < #name description# >
 *  @param mallSaleDetailId <#mallSaleDetailId#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)CrmUserLikeMallProductWithmallProductId:(NSString *)mallProductId Success:(void(^)(NSDictionary *orderDic))success failture:(void(^)(NSString *errMsg))failture;

/**
 *  取消喜欢产品
 *  < #name description# >
 *  @param mallSaleDetailId <#mallSaleDetailId#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)CrmUserUnlikeMallProductWithmallProductId:(NSString *)mallProductId Success:(void(^)(NSDictionary *orderDic))success failture:(void(^)(NSString *errMsg))failture;


/**
 *  获取喜欢的列表
 *  < #name description# >
 *  @param mallSaleDetailId <#mallSaleDetailId#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)ListCrmUserLikeMallProductSuccess:(void(^)(NSArray *orderArray))success failture:(void(^)(NSString *errMsg))failture;


/**
 *  使用代金券
 *  < #name description# >
 *  @param mallSaleDetailId <#mallSaleDetailId#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)OmSaleOrderSetCrmCouponId:(NSString *)crmCouponId  omSaleOrderHeaderId:(NSString *)omSaleOrderHeaderId Success:(void(^)(NSArray *orderArray))success failture:(void(^)(NSString *errMsg))failture;

/**
 *   省份数据
 *  < #name description# >
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)RequestProvinceSuccess:(void(^)(NSArray *provinceArray)) success failture:(void(^)(NSString *errMsg))failture;

/**
 *   城市数据
 *  < #name description# >
 * @param idstring <#idstring#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)RequestCityWithProvinceID:(NSString *)idString Success:(void(^)(NSArray *cityArray)) success failture:(void(^)(NSString *errMsg))failture;


/**
 *   地区数据
 *  < #name description# >
 * @param idstring <#idstring#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)RequestDistrictWithCityID:(NSString *)idString Success:(void(^)(NSArray *dictrictArray)) success failture:(void(^)(NSString *errMsg))failture;


/**
 *   保存地址
 *  < #name description# >
 * @param idstring <#idstring#>
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)CreateWmsShippingAddressWithDistrictID:(NSString *)idString andAddress:(NSString *)address andShippingToName:(NSString *)shopNameString shippingToPhone:(NSString *)shippingToPhone andisDefault:(NSString *)isDefault Success:(void(^)(id dictrictArray)) success failture:(void(^)(NSString *errMsg))failture;

/**
 *   获取地址
 *  < #name description# >
 *  @param success  <#success description#>
 *  @param failture <#failture description#>
 */
-(void)GetlistWmsShippingAddressSuccess:(void(^)(NSArray *dictrictArray))success failture:(void(^)(NSString *errMsg))failture;



@end
