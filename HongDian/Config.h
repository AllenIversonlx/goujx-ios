//
//  Config.h
//  godstreet
//
//  Created by Dave on 15/3/2.
//  Copyright (c) 2015年 HONG DIAN. All rights reserved.
//


#ifndef godstreet_Config_h
#define godstreet_Config_h

#import "UIColor+Utils.h"

#define SaveAddressKey  @"SaveAddressKey"

#define SaveTokenKey        @"accessToken"
#define DeviceToken             @"DeviceToken"

#define PersonInformation  @"personInformation"

#define PersonName        @"PersonName"

#define omCrmUserLikeProduct        @"omCrmUserLikeProduct"
#define omCrmCouponCount        @"omCrmCouponCount"
#define omSaleOrderCount        @"omSaleOrderCount"


#define out_trade_no            @"out_trade_no"

#define JXC_OM_SALE_ORDER_PAYMENT_CHANNEL_KEY_WECHATPAY    @"10"
#define JXC_OM_SALE_ORDER_PAYMENT_CHANNEL_KEY_ALIPAY       @"20"

#define iPhone5   ([UIScreen mainScreen].bounds.size.width == 320)
#define iPhone6   ([UIScreen mainScreen].bounds.size.width == 375)
#define iPhone6p  ([UIScreen mainScreen].bounds.size.width == 414)

#define  iphone5Width 20
#define  iphone6Width 37.5
#define  iphone6pWidth  32

#define iphone5ImageWidth  280
#define iphone6ImageWidth  300
#define iphone6pImageWidth  350

#define iphone5ImageHeight  392
#define iphone6ImageHeight  420
#define iphone6pImageHeight  490



#define iOS8_OR_Later   [[UIDevice currentDevice] systemVersion].floatValue >= 8
#define SegmentArray       @[@"她说",@"美物"]
#define SettingArray @[@"购物车",@"订单",@"待支付",@"收藏",@"优惠券",@"设置"]



#define ShopMainBaseUrl     @"http://rest.dev.goujx.com/v1/mall/list-mall-sale.html?id=1&fields=id,name,describe,displayDate,likeCount,readCount&expand=cover,baseWeather";

#define UserTermsUrl                        @"http://prd.goujx.com/embed/default/terms.html"

#define UserAboutUrl                        @"http://prd.goujx.com/embed/default/about.html"

#define ContentUsUrl                        @"http://dev.goujx.com/embed/default/contact.html"

#define LoginSuccessNotification       @"LoginSuccessNotification"

#define ThemeViewColor                 [UIColor colorWithHexString:@"#b4ebe8"]//kThemeViewColor
#define TabBtnSelectedColor            [UIColor colorWithHexString:@"#060606"]//TabBtnSelectedColor
#define NavigationBarColor             [UIColor colorWithHexString:@"#212121"]//NavigationBarColor
#define TopBarControlColor             [UIColor colorWithHexString:@"#161616"]//TopBarControlColor
#define ThemeFontColor                 [UIColor colorWithHexString:@"#8de7de"]//ThemeFontColor
#define TabBarNormalColor              [UIColor colorWithHexString:@"#1c1c1c"]//TabBarNormalColor
#define CancleNomalColer              [UIColor colorWithHexString:@"#D7D7D7"]//CancleNomalColer

#define TimeColor              [UIColor colorWithHexString:@"#F1F1F1"]//CancleNomalColer


#define BuyCarNameColor     [UIColor colorWithHexString:@"#4A4A4A"]


#define ButtonColor      [UIColor colorWithHexString:@"#50e3c2"]
#define UserFont           @"FZLanTingHei-EL-GBK"

#define TextLabelFont    [UIFont fontWithName:UserFont size:17]
#define  LittleTextLabelFont     [UIFont fontWithName:UserFont size:13]
#define BackGroundColor   [UIColor colorWithHexString:@"#FDFCFC"]
#define LoginOutColor   [UIColor colorWithHexString:@"#FF6A8A"]
#define LoginInColor       [UIColor colorWithHexString:@"#50E3C2"]
#define ProfileLikeColor     [UIColor colorWithHexString:@"#C2C2C2"]
#define DelayToPayOrderColor   [UIColor colorWithHexString:@"#FF6A8A"]
#define AddOrMiusColor      [UIColor colorWithHexString:@"#979797"]
#define CouponMoneyLabelColor   [UIColor colorWithHexString:@"#E39FCA"]


//优惠券已经过期
#define CouponDateOld   [UIColor colorWithHexString:@"#9F9FAC"]
//优惠券未使用
#define CouponNotUsed   [UIColor colorWithHexString:@"#B8E986"]
//优惠券已使用
#define CouponUsed   [UIColor colorWithHexString:@"#FF6A8A"]

//等待发货
#define WaitForTheDelivery         [UIColor colorWithHexString:@"#F5A623"]
#define HasTheDelivery                  [UIColor colorWithHexString:@"#4A4A4A"]
#define WaitForPayTheGood          [UIColor colorWithHexString:@"#FF6A8A"]
#define CancleTheOrder                 [UIColor colorWithHexString:@"#9F9FAC"]


#define SinaAppKey   @"3731403874"
#define SinaSecretKey @"de0a499be5f95349d810180dfd148c8b"

#define UM_APPKEY_JX                  @"54fdb1f0fd98c5162500000f"
#define WX_APP_ID_JX                  @"wx82b2a93bb687f5c1"
#define WeChatLaod                      @"http://s2.goujx.com/jxapi/wechatlogin"
#define WX_APP_KEY                           @"11112222333344445555666677770000"



#define WX_APP_SECRET_JX              @"f4375ef9995ba58808773334a3fb3940"
#define JX_DOWNLOAD_URL               @"https://itunes.apple.com/cn/app/jin-xiang/id966790905"
#define  KNotificationWXSTR         @"jinxiangWechatLoad"
#define KSportUserID                  @"sporyID"
#define KSportUserNameKey     @"KSportUserNameKey"
#define KSportHeadImageKey       @"KSportHeadImageKey"
#define kWeiXinRefreshToken          @"kWeiXinRefreshToken"

#define APP_USER_AGENT_JX             @"jinxiang"//添加至浏览器userAgent，作为客户端访问 标识

//interfaces

// address of Server

#define LoadParperidWeiXinUrl                    @"http://goujx.com/wechat/pay"
#define LoadParperidWeiXinUrl2                    @"http://123.56.95.224:9208/wechat/pay"

#define CallBackWeChatUrl                          @"http://goujx.com/wechat/pay/queryStatus"

#define CallBackWeChatUrl2                          @"http://123.56.95.224:9208/wechat/pay/queryStatus"

#define WeiXinUrl                  @"https://api.weixin.qq.com/"




//
#define   UpdateHeadPic                 @"user/info/headImage"//上传头像 // not used
#define   AddToCommunityShare           @"share/share/add"//社区 发布信息
#define   AddComment                    @"share/shareComment/add"//发表评论
#define   ALiSign                       @"goods/alipay/sign"//签名接口

//回调URL
#define JX_NOTIFY_URL_ORDER_ID                 @"http://m.goujx.com/jxapi/goods/alipaynode"//订单支付
#define JX_NOTIFY_URL_PAY_ORDER_ID                 @"http://m.goujx.com/jxapi/goods/alipaynodepay"//


//5.21 AliPay
static NSString * const kJXPartner = @"2088811543737342";//支付宝商户号
static NSString * const kJXSeller  = @"willie_yao@yahoo.com";//支付宝卖家账号
//5.26 WXPay
static NSString * const kJX_WX_Partner = @"1241925202";//微信商户号


static NSString * const kJXAPPScheme = @"JinXiang";//App回调 URL SCHEME,也需要在plist文件里面修改。

static NSString * const kDidSuccessAddToCommunityNotification = @"kDidSuccessAddToCommunityNotification";

//5.27
static NSString * const kOrderPayNotificationWX = @"kOrderPayNotificationWX";

static inline CGFloat Screen_Width()
{
    return ([[UIScreen mainScreen]bounds].size.width);
}

static inline CGFloat Screen_Height()
{
    return ([[UIScreen mainScreen]bounds].size.height);
}

#endif
