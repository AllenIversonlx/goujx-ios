 //
//  JXRequestManager.m
//  HongDian
//
//  Created by 姜通 on 15/7/28.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "JXRequestManager.h"
#import "JSONKit.h"
#import "Config.h"

#define BaseUrl                                 @"http://rest.dev.goujx.com/v1"

#define  LoadUrl                                @"/profile/authorize.html"
#define SendAuthTokenUrl                @"/profile/send-mobile-auth-token.html"
#define  RegisterUrl                                @"/profile/register.html"
#define UpdatepasswordUrl                 @"/profile/update-password.html"
#define GetPersonInformationBaseUrl  @"/profile/view-crm-user.html"
#define GetPersonInformationUrl       @"&fields=id,email,name,params,mobile,birthday&expand=avatar,baseGender,omSaleOrderCount,omCrmCouponCount,omCrmUserLikeProduct"

#define ShopMainSaleUrl                     @"/mall/list-mall-sale.html"
#define SingleProductUrl                       @"/mall/view-mall-product.html?fields=id,name,brief,productId,salePrice&expand=image,mallProductBrand,mallProductAttribute,mallProductDescribe,color,size,mallProductSkuMap,mallProductSkuStock"

#define ShopViewMallSaleUrl                    @"/mall/view-mall-sale.html?mallSaleId=1&fields=id,name,describe,displayDate,likeCount,readCount&expand=cover,baseWeather,mallSaleDetail"

#define CrmUserLikeMallProductUrl               @"/profile/crm-user-like-mall-product.html"

#define CrmUserUnlikeMallProductUrl             @"/profile/crm-user-unlike-mall-product.html"
#define ListCrmUserLikeMallProduct                 @"/profile/list-crm-user-like-mall-product.html?fields=id&expand=mallProduct"

#define RegisterIosDeviceTokenUrl                  @"/profile/register-ios-device-token.html"

#define ShopMallProductUrl      @"/mall/list-mall-product.html?fields=id,name,salePrice&expand=cover"

#define GetCouponBaseUrl      @"/profile/list-crm-coupon.html"
#define UpdateCrmUserUrl           @"/profile/update-crm-user.html"

#define CancelOmSaleOrderUrl        @"/mall/cancel-om-sale-order.html"

#define GetViewOrderBaseUrl   @"/mall/view-om-sale-order.html"

#define GetViewOrderDetailUrl    @"&fields=id,documentNum,filingDate,totalAmount&expand=omSaleOrderHeaderStatus,basePaymentStatus,omSaleOrderDetail,wmsShipmentHeader,crmCoupon,omSaleOrderPayment,displayStatus"

#define ChangeTheaddressUrl     @"/mall/om-sale-order-set-wms-shipping-address.html"
#define ChangeTheCouponUrl      @"/mall/om-sale-order-set-crm-coupon.html"


#define ShopMallProductClassUrl                @"/mall/list-mall-product-class.html?fields=id,name"
#define ShopCreatSaleOrderUrl                   @"/mall/create-om-sale-order.html"
#define ShopListOmSaleOrderUrl                   @"/mall/list-om-sale-order.html"
#define ShopAddToCarUrl                             @"/cart/set-cart.html"
#define ShopListCarUrl                                   @"/cart/list-cart.html"
#define ShopDeleteFromCartUrl                     @"/cart/set-cart.html"
#define PayGoogdUrl                                     @"/mall/pay-om-sale-order.html"
#define WechatPayBackUrl                                @"/mall/view-om-sale-order.html"
#define AliPayBakUrl                                @"/mall/update-om-sale-order-payment-status.html"

//省份
#define GetProvinceUrl                                      @"/mall/list-sys-hat-province.html"
#define GetCityUrl                                              @"/mall/list-sys-hat-city.html"
#define GetDistrictUrl                                          @"/mall/list-sys-hat-district.html"
#define CreateWmsShippingAddressUrl             @"/mall/create-wms-shipping-address.html"
#define GetProvinceAndCityAndDistrictUrl         @"/mall/list-wms-shipping-address.html?fields=id,address,shippingToName,shippingToPhone,isDefault"


@implementation JXRequestManager

+ (instancetype)sharedNetWorkManager
{
    static JXRequestManager *netWorkManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorkManager = [[[self class]alloc]init];
        netWorkManager.securityPolicy.allowInvalidCertificates = YES;
    });
    return netWorkManager;
}

-(NSString*) uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

#pragma mark - 上传token
-(void)RegisterIosDeviceToken:(NSData *)data success:(void(^)(NSString *token))success failture:(void(^)(NSString *errMsg))failture {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:data,@"iOSDeviceToken", nil];
    [self POST:[NSString stringWithFormat:@"%@%@?access-token=%@",BaseUrl,RegisterIosDeviceTokenUrl,token] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        success(@"成功");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failture(@"失败");
    }];
}

#pragma mark - 登录
- (void)requestLoadUserWithMobileNumber:(NSString *)mobileNo andpassword:(NSString *)pwd success:(void(^)(NSString *token))success failture:(void(^)(NSString *errMsg))failture{
    NSString *uuidString = [self uuid];
    NSDictionary *param = @{@"mobile":mobileNo,@"password":pwd,@"iOSDeviceToken":uuidString};
    [self POST:[NSString stringWithFormat:@"%@%@",BaseUrl, LoadUrl] parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"success"] intValue] == 1) {
            NSString *accessToken = [responseObject objectForKey:@"data"];
            [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:SaveTokenKey];
            success(accessToken);
        } else {
            NSString *message = [[responseObject objectForKey:@"data"] objectForKey:@"message"];
            failture(message);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = = %@",error);
        failture([NSString stringWithFormat:@"%@",error]);
    }];
}

#pragma mark - 发送验证码
- (void)SendMobileAuthTokenWithMobileNumber:(NSString *)mobileNo success:(void(^)(NSString *token))success failture:(void(^)(NSString *errMsg))failture{
//    NSDictionary *dic = @{@"mobile":mobileNo};
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:mobileNo,@"mobile", nil];
    [self POST:[NSString stringWithFormat:@"%@%@",BaseUrl,SendAuthTokenUrl] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"success"] intValue]== 1) {
            NSString *mobileAuthToken = [responseObject objectForKey:@"data"];
            [[NSUserDefaults standardUserDefaults] setObject:mobileAuthToken forKey:@"mobileAuthToken"];
            success(mobileAuthToken);
        } else {
            NSString *message = [[responseObject objectForKey:@"data"] objectForKey:@"message"];
            failture(message);
        }
        /* {
         code = 0;
         message =     {
         mobileAuthToken = 30093;
         };
         name = Success;
         status = 200;
         }*/
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failture([NSString stringWithFormat:@"%@",error]);
        NSLog(@"%@",[NSString stringWithFormat:@"%@",error]);
    }];
}

#pragma mark - 注册
-(void)RegisterWithMobileNumber:(NSString *)mobileNo pwd:(NSString *)pwd name:(NSString *)name photoImahe:(UIImage *)image andAccessToken:(NSString *)token success:(void(^)(NSString *token))success failture:(void(^)(NSString *errMsg))failture{

    NSData *imgData  = [self imageWithImage:image scaledToSize:CGSizeMake(250, 250)];
    NSString *uuidString = [self uuid];
    NSDictionary *dic = @{@"mobile":mobileNo,@"name":name,@"iOSDeviceToken":uuidString};
    NSDictionary *param = @{@"CrmUser":dic,@"password":pwd,@"mobileVerifyToken":token};
    
    [self POST:[NSString stringWithFormat:@"%@%@",BaseUrl,RegisterUrl] parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imgData name:@"avatar" fileName:@"avatarFile" mimeType:@"image/png"];        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"success"] intValue]== 1) {
            NSString *accessToken = [responseObject objectForKey:@"data"];
            [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:SaveTokenKey];
            success(accessToken);
            NSLog(@"%@",[NSString stringWithFormat:@"%@",accessToken]);
        } else {
                NSString *message = [[responseObject objectForKey:@"data"] objectForKey:@"message"];
                failture(message);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",[NSString stringWithFormat:@"%@",error]);
    }];
}

#pragma maek - 修改头像
-(void)actionUpdateCrmUserImage:(UIImage*)image success:(void(^)(NSDictionary *successDic))success failture:(void(^)(NSString *errMsg))failture{
    NSData *imgData  = [self imageWithImage:image scaledToSize:CGSizeMake(250, 250)];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    [self POST:[NSString stringWithFormat:@"%@%@?access-token=%@",BaseUrl,UpdateCrmUserUrl,token] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imgData name:@"avatar" fileName:@"avatarFile" mimeType:@"image/png"];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [responseObject objectForKey:@"data"];
        success(dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
     
    }];
}

-(void)actionUpdateCrmUserNickName:(NSString*)nickName success:(void(^)(NSDictionary *successString))success failture:(void(^)(NSString *errMsg))failture{
    NSDictionary *dic = @{@"name":nickName};
    NSDictionary *param = @{@"CrmUser":dic};
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    [self POST:[NSString stringWithFormat:@"%@%@?access-token=%@",BaseUrl,UpdateCrmUserUrl,token] parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [responseObject objectForKey:@"data"];
        success(dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (NSData *)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(newImage, 0.8);
}

#pragma mark - 获取个人信息
-(void)GetPersonInformationsuccess:(void(^)(NSDictionary *dic))success failture:(void(^)(NSString *errMsg))failture{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    [self POST:[NSString stringWithFormat:@"%@%@?access-token=%@%@",BaseUrl,GetPersonInformationBaseUrl,token,GetPersonInformationUrl] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [responseObject objectForKey:@"data"];
        success(dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failture(@"获取个人信息失败");
    }];
}

#pragma mark - 修改密码
-(void)RegisterWithNewPwd:(NSString *)pwdNew pwdOld:(NSString *)pwdOld success:(void(^)(NSString *token))success failture:(void(^)(NSString *errMsg))failture{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    NSDictionary *dic = @{@"oldPassword":pwdOld,@"newPassword":pwdNew};
    [self POST:[NSString stringWithFormat:@"%@%@?access-token=%@",BaseUrl,UpdatepasswordUrl,token] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status intValue] == 200) {
            NSLog(@"修改成功");
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = = %@",error);
        failture([NSString stringWithFormat:@"%@",error]);
    }];
}

#pragma mark -  获取首页sale数据
-(void)requestShopWithUrl:(NSString *)url MaimSaleAndSuccess:(void(^)(NSArray *items, NSDictionary *linksArray))success failture:(void(^)(NSString *errMsg))failture{
    [self POST:[NSString stringWithFormat:@"%@",url] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [[responseObject objectForKey:@"data"] objectForKey:@"items"];
        NSDictionary *linksArray = [[responseObject objectForKey:@"data"] objectForKey:@"_links"];
        success(array,linksArray);
//        NSLog(@"responseObject  = =%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = = %@",error);
        failture([NSString stringWithFormat:@"%@",error]);
    }];
}

#pragma mark - 首页详细数据
-(void)RequestListMallProductWithMallProductSearch:(NSString *)searchString Success:(void(^)(NSArray *mallProductArray)) success failture:(void(^)(NSString *errMsg))failture{
   [self POST:[NSString stringWithFormat:@"%@%@",BaseUrl,ShopMallProductUrl] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
       NSArray *array = [[responseObject objectForKey:@"data"] objectForKey:@"items"];
       success(array);
   } failure:^(NSURLSessionDataTask *task, NSError *error) {
       failture(@"获取信息失败");
   }];
}

#pragma mark - 获取商品列表的种类
-(void)RequestListMallProductClassSuccess:(void(^)(NSArray *mallProductArray))success failture:(void(^)(NSString *errMsg))failture{
    [self POST:[NSString stringWithFormat:@"%@%@",BaseUrl,ShopMallProductClassUrl] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [[responseObject objectForKey:@"data"] objectForKey:@"items"];
        success(array);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failture(@"获取信息失败");
    }];
}

#pragma mark - 获取单个商品的数据
-(void)RequestViewMallProduceWithIdString:(NSString *)idString Success:(void(^)(NSDictionary *singledic)) success failture:(void(^)(NSString *errMsg))failture{
    //mallProductId=5062&
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:idString,@"mallProductId", nil];
    [self POST:[NSString stringWithFormat:@"%@%@",BaseUrl,SingleProductUrl] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *status = [responseObject objectForKey:@"success"];
        if ([status boolValue] == 1) {
            NSDictionary *dic = [responseObject objectForKey:@"data"];
            success(dic);
        }  else {
        
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = = %@",error);
        failture([NSString stringWithFormat:@"%@",error]);
    }];
}

#pragma mark - 喜欢产品
-(void)CrmUserLikeMallProductWithmallProductId:(NSString *)mallProductId Success:(void(^)(NSDictionary *orderDic))success failture:(void(^)(NSString *errMsg))failture{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:mallProductId,@"mallProductId", nil];
    [self POST:[NSString stringWithFormat:@"%@%@?access-token=%@",BaseUrl,CrmUserLikeMallProductUrl,token] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *string = [responseObject objectForKey:@"success"];
        if ([string boolValue] == 1) {
            success(responseObject);
        } else {
            failture(@"收藏失败");
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = = %@",error);
        failture([NSString stringWithFormat:@"%@",error]);
    }];
}

#pragma mark - 取消喜欢
-(void)CrmUserUnlikeMallProductWithmallProductId:(NSString *)mallProductId Success:(void(^)(NSDictionary *orderDic))success failture:(void(^)(NSString *errMsg))failture{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:mallProductId,@"mallProductId", nil];
    [self POST:[NSString stringWithFormat:@"%@%@?access-token=%@",BaseUrl,CrmUserUnlikeMallProductUrl,token] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *string = [responseObject objectForKey:@"success"];
        if ([string boolValue] == 1) {
            success(responseObject);
        } else {
            failture(@"取消收藏失败");
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = = %@",error);
        failture([NSString stringWithFormat:@"%@",error]);
    }];
}

#pragma mark - 获取喜欢的列表
-(void)ListCrmUserLikeMallProductSuccess:(void(^)(NSArray *orderArray))success failture:(void(^)(NSString *errMsg))failture{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    [self POST:[NSString stringWithFormat:@"%@%@&access-token=%@",BaseUrl,ListCrmUserLikeMallProduct,token] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [[responseObject objectForKey:@"data"] objectForKey:@"items"];
        success(array);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - 获取商品滑动界面的数据
-(void)RequestShopDetailWithidString:(NSString *)idString Success:(void(^)(NSDictionary *singledic)) success failture:(void(^)(NSString *errMsg))failture{
    NSDictionary *dic = @{@"mallSaleId":idString};
    [self POST:[NSString stringWithFormat:@"%@%@",BaseUrl,ShopViewMallSaleUrl] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [responseObject objectForKey:@"data"] ;
        success(dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = = %@",error);
        failture([NSString stringWithFormat:@"%@",error]);
    }];
}

#pragma mark- 加入购物车
-(void)AddToCartWithmallProductSkuId:(NSString *)mallProductSkuId andquantity:(NSString *)quantity Success:(void(^)(NSArray *orderArray))success failture:(void(^)(NSString *errMsg))failture{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:mallProductSkuId,@"mallProductSkuId", quantity,@"quantity", nil];
    [self POST:[NSString stringWithFormat:@"%@%@?access-token=%@",BaseUrl,ShopAddToCarUrl,token] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = = %@",error);
        failture([NSString stringWithFormat:@"%@",error]);
    }];
}

#pragma mark - 查看购物车
-(void)RequestListCarSuccess:(void(^)(NSArray *orderArray))success failture:(void(^)(NSString *errMsg))failture{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    [self POST:[NSString stringWithFormat:@"%@%@?access-token=%@",BaseUrl,ShopListCarUrl,token] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@",responseObject);
        NSString *string = [responseObject objectForKey:@"success"];
        if ([string boolValue] == 0) {
            failture(string);
        } else if ([string boolValue] == 1) {
            NSArray *array = [responseObject objectForKey:@"data"];
            success(array);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = = %@",error);
        failture([NSString stringWithFormat:@"%@",error]);
    }];
}

#pragma mark 删除一件商品
-(void)DeleteFromCarWithMallProductSkuId:(NSString *)mallProductSkuId andGoodsCount:(NSString *)goodsCount Success:(void(^)(NSArray *orderArray))success failture:(void(^)(NSString *errMsg))failture{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:mallProductSkuId,@"mallProductSkuId", goodsCount,@"quantity",nil];
    [self POST:[NSString stringWithFormat:@"%@%@?access-token=%@",BaseUrl,ShopDeleteFromCartUrl,token] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = = %@",error);
        failture([NSString stringWithFormat:@"%@",error]);
    }];
}

#pragma mark -生成订单
-(void)createOmSaleOrderWithAddressIdString:(NSString *)addressIdString andCoupon:(NSString *)coupon mallArray:(NSMutableArray *)array Success:(void(^)(NSDictionary *omSaleDic)) success failture:(void(^)(NSString *errMsg))failture{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    NSString *jsonString = [self DataToJsonString:array];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:jsonString,@"omSaleOrderDetail",addressIdString,@"wmsShippingAddressId", coupon, @"crmCouponId", nil];
    [self GET:[NSString stringWithFormat:@"%@%@?access-token=%@",BaseUrl,ShopCreatSaleOrderUrl,token] parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *successString = [responseObject objectForKey:@"success"];
        if ([successString boolValue] == 1) {
            NSDictionary *dic = [responseObject objectForKey:@"data"];
            success(dic);
        } else {
            failture(@"下单失败");
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = = %@",error);
        failture([NSString stringWithFormat:@"%@",error]);
    }];
}

#pragma mark - 获取全部订单
-(void)ListOmSaleOrderWithOrderStatus:(NSString *)statusStrig Success:(void(^)(NSArray *orderArray))success failture:(void(^)(NSString *errMsg))failture{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    NSString *urlString = [NSString stringWithFormat:@"%@%@?access-token=%@&%@",BaseUrl,ShopListOmSaleOrderUrl,token,statusStrig];
   [self POST:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
       NSArray *array = [[responseObject objectForKey:@"data"] objectForKey:@"items"];
       success(array);
   } failure:^(NSURLSessionDataTask *task, NSError *error) {
       NSLog(@"error = = %@",error);
       failture([NSString stringWithFormat:@"%@",error]);
   }];
}

#pragma mark - 更改地址
-(void)OmSaleOrderSetShippingAddressId:(NSString *)addressId  omSaleOrderHeaderId:(NSString *)omSaleOrderHeaderId Success:(void(^)(NSArray *orderArray))success failture:(void(^)(NSString *errMsg))failture{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:addressId,@"wmsShippingAddressId",omSaleOrderHeaderId,@"omSaleOrderHeaderId", nil];
    [self POST:[NSString stringWithFormat:@"%@%@?access-token=%@",BaseUrl,ChangeTheaddressUrl,token] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - 使用代金券
-(void)OmSaleOrderSetCrmCouponId:(NSString *)crmCouponId  omSaleOrderHeaderId:(NSString *)omSaleOrderHeaderId Success:(void(^)(NSArray *orderArray))success failture:(void(^)(NSString *errMsg))failture{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:crmCouponId,@"crmCouponId",omSaleOrderHeaderId,@"omSaleOrderHeaderId", nil];
    [self POST:[NSString stringWithFormat:@"%@%@?access-token=%@",BaseUrl,ChangeTheCouponUrl,token] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - 获取订单详情
-(void)ViewOmSaleOrderWithOrderIdString:(NSString *)idstring Success:(void(^)(NSDictionary *orderDic))success failture:(void(^)(NSString *errMsg))failture{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:idstring, @"omSaleOrderHeaderId", nil];
//    NSString *string = [NSString stringWithFormat:@"%@%@?access-token=%@%@",BaseUrl,GetViewOrderBaseUrl ,token,GetViewOrderDetailUrl];
    [self POST:[NSString stringWithFormat:@"%@%@?access-token=%@&%@",BaseUrl,GetViewOrderBaseUrl ,token,GetViewOrderDetailUrl] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [responseObject objectForKey:@"data"];
        success(dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failture(@"获取优惠券失败");
    }];
}

#pragma mark - 取消订单
-(void)CancelOmSaleOrderWithSaleOrderHeaderId:(NSString *)SaleOrderHeaderId Success:(void(^)(NSDictionary *orderDic))success failture:(void(^)(NSString *errMsg))failture{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:SaleOrderHeaderId ,@"omSaleOrderHeaderId", nil];
    [self POST:[NSString stringWithFormat:@"%@%@?access-token=%@",BaseUrl,CancelOmSaleOrderUrl ,token] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failture(@"取消订单失败");
    }];
}

#pragma mark - 获取优惠券
-(void)ListCrmCouponOrderStatus:(NSString *)statusStrig Success:(void(^)(NSArray *orderArray))success failture:(void(^)(NSString *errMsg))failture{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
   [self POST:[NSString stringWithFormat:@"%@%@?access-token=%@&%@",BaseUrl,GetCouponBaseUrl,token,statusStrig] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
       NSArray *array = [[responseObject objectForKey:@"data"] objectForKey:@"items"];
       success(array);
   } failure:^(NSURLSessionDataTask *task, NSError *error) {
       failture(@"获取优惠券失败");
   }];
}

-(NSString*)DataToJsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

#pragma mark - 微信支付
-(void)PayGoodsWithPaymentChannel:(NSString *)paymentChannel andomSaleOrderHeaderId:(NSString *)omSaleOrderHeaderId Success:(void(^)(NSDictionary *orderDic))success failture:(void(^)(NSString *errMsg))failture{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:paymentChannel,@"omSaleOrderPaymentChannelKey",omSaleOrderHeaderId,@"omSaleOrderHeaderId", nil];
    [self POST:[NSString stringWithFormat:@"%@%@?access-token=%@",BaseUrl,PayGoogdUrl,token] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [responseObject objectForKey:@"data"];
        success(dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = = %@",error);
        failture([NSString stringWithFormat:@"%@",error]);
    }];
}

#pragma mark - 支付宝
-(void)PayGoodsWithAliPayPaymentChannel:(NSString *)paymentChannel andomSaleOrderHeaderId:(NSString *)omSaleOrderHeaderId Success:(void(^)(NSDictionary *alipayDic))success failture:(void(^)(NSString *errMsg))failture{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:paymentChannel,@"omSaleOrderPaymentChannelKey",omSaleOrderHeaderId,@"omSaleOrderHeaderId", nil];
    [self POST:[NSString stringWithFormat:@"%@%@?access-token=%@",BaseUrl,PayGoogdUrl,token] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = = %@",error);
        failture([NSString stringWithFormat:@"%@",error]);
    }];
}


#pragma mark - 微信支付回调
-(void)WeChatPayGoodsWithOmSaleOrderHeaderId:(NSString *)omSaleOrderHeaderId Success:(void(^)(NSDictionary *orderDic))success failture:(void(^)(NSString *errMsg))failture{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:omSaleOrderHeaderId,@"omSaleOrderHeaderId", nil];
    [self POST:[NSString stringWithFormat:@"%@%@?access-token=%@",BaseUrl,WechatPayBackUrl,token] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = = %@",error);
        failture([NSString stringWithFormat:@"%@",error]);
    }];
}

#pragma mark - 支付宝回掉
-(void)AliPayGoodsWithOmSaleOrderHeaderId:(NSString *)omSaleOrderHeaderId Success:(void(^)(NSDictionary *orderDic))success failture:(void(^)(NSString *errMsg))failture{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:omSaleOrderHeaderId,@"omSaleOrderHeaderId", nil];
    [self POST:[NSString stringWithFormat:@"%@%@?access-token=%@",BaseUrl,AliPayBakUrl,token] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = = %@",error);
        failture([NSString stringWithFormat:@"%@",error]);
    }];
}

#pragma mark - 获取省份名称
-(void)RequestProvinceSuccess:(void(^)(NSArray *provinceArray)) success failture:(void(^)(NSString *errMsg))failture{
    [self POST:[NSString stringWithFormat:@"%@%@",BaseUrl,GetProvinceUrl] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [responseObject objectForKey:@"items"];
        success(array);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = = %@",error);
        failture([NSString stringWithFormat:@"%@",error]);
    }];
}

#pragma mark - 获取城市名称
-(void)RequestCityWithProvinceID:(NSString *)idString Success:(void(^)(NSArray *cityArray)) success failture:(void(^)(NSString *errMsg))failture{
    NSString *page = @"1000";
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:idString,@"sysHatProvinceId", nil];
    [self POST:[NSString stringWithFormat:@"%@%@?per_page=%@",BaseUrl,GetCityUrl,page] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [responseObject objectForKey:@"items"];
        success(array);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = = %@",error);
        failture([NSString stringWithFormat:@"%@",error]);
    }];
}

#pragma mark - 获取地区名称
-(void)RequestDistrictWithCityID:(NSString *)idString Success:(void(^)(NSArray *dictrictArray)) success failture:(void(^)(NSString *errMsg))failture{
    NSString *page = @"1000";
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:idString,@"sysHatCityId", nil];

    [self POST:[NSString stringWithFormat:@"%@%@?per_page=%@",BaseUrl,GetDistrictUrl,page] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [responseObject objectForKey:@"items"];
        success(array);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = = %@",error);
        failture([NSString stringWithFormat:@"%@",error]);
    }];
}

#pragma mark - 保存地址
-(void)CreateWmsShippingAddressWithDistrictID:(NSString *)idString andAddress:(NSString *)address andShippingToName:(NSString *)shopNameString shippingToPhone:(NSString *)shippingToPhone andisDefault:(NSString *)isDefault Success:(void(^)(id dictrictArray)) success failture:(void(^)(NSString *errMsg))failture{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:idString,@"sysHatDistrictId",address,@"address",shopNameString,@"shippingToName",shippingToPhone,@"shippingToPhone",isDefault,@"isDefault", nil];
    [self POST:[NSString stringWithFormat:@"%@%@?access-token=%@",BaseUrl,CreateWmsShippingAddressUrl,token] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",[NSString stringWithFormat:@"%@",error]);
    }];
}

#pragma mark - 获取省份城市列表
-(void)GetlistWmsShippingAddressSuccess:(void(^)(NSArray *dictrictArray))success failture:(void(^)(NSString *errMsg))failture{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    [self POST:[NSString stringWithFormat:@"%@%@&access-token=%@",BaseUrl,GetProvinceAndCityAndDistrictUrl,token] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [[responseObject objectForKey:@"data"] objectForKey:@"items"];
        success(array);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failture(@"获取地址失败");
    }];
}

@end
