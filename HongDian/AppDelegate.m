//
//  AppDelegate.m
//  HongDian
//
//  Created by 姜通 on 15/7/9.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "AppDelegate.h"
#import "RightSettingViewController.h"
#import "ShopMainViewController.h"
#import "LeftSaleViewController.h"
#import "WXApi.h"
#import "Config.h"
#import <WeiboSDK/WeiboSDK.h>
#import <AlipaySDK/AlipaySDK.h>
#import "JXRequestManager.h"
#import <Masonry/Masonry.h>
#import "JXRequestManager.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.backgroundColor = [UIColor whiteColor];
    
    ShopMainViewController *shopMain = [[ShopMainViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:shopMain];
//    LeftSaleViewController *leftVC = [[LeftSaleViewController alloc] init];
//    RightSettingViewController *rightVC = [[RightSettingViewController alloc] init];
//    RESideMenu *sideMenuVC = [[RESideMenu alloc] initWithContentViewController:nav leftMenuViewController:leftVC rightMenuViewController:rightVC];
//    self.window.rootViewController = sideMenuVC;
    self.window.rootViewController = nav;

//    sideMenuVC.menuPreferredStatusBarStyle = 1;
//    sideMenuVC.delegate = self;
//    sideMenuVC.contentViewShadowColor = [UIColor blackColor];
//    sideMenuVC.contentViewShadowOffset = CGSizeMake(0, 0);
//    sideMenuVC.contentViewShadowOpacity = 0.6;
//    sideMenuVC.contentViewShadowRadius = 12;
//    sideMenuVC.contentViewShadowEnabled = YES;
//    
    [self.window makeKeyAndVisible];
    
    
    NSString *userAgent = [[[UIWebView alloc]init]stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSString *clientuserAgent = APP_USER_AGENT_JX;
    NSString *version = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    NSString *customUserAgent = [userAgent stringByAppendingFormat:@" %@/%@",clientuserAgent,version];
    [[NSUserDefaults standardUserDefaults]registerDefaults:@{@"UserAgent":customUserAgent}];

    //向微信注册
    [WXApi registerApp:WX_APP_ID_JX withDescription:[NSString stringWithFormat:@"%@%@",kJXAPPScheme,version]];
    
    //微博注册
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:SinaAppKey];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
    {
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)]) {
            [[UIApplication sharedApplication] performSelector:@selector(registerForRemoteNotifications) withObject:nil];
        }
        UIUserNotificationType types = UIUserNotificationTypeBadge                                                                                                                      | UIUserNotificationTypeSound | UIUserNotificationTypeAlert ;
        
        UIUserNotificationSettings * setting =  [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    return YES;
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:DeviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}


#pragma mark - WXApiDelegate
-(void) onResp:(BaseResp*)resp
{
    NSString *strTitle;
    NSString *strMsg;
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"%@",resp.errStr];
        strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }   else if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *response = (PayResp *)resp;
        strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (response.errCode) {
            case WXSuccess:
            {
                [self OrderToSureTheSuccessWeChatPay];
                //添加延迟
                //                timerr = 0;
//                NSTimer *myTimer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(OrderToSureTheSuccessWeChatPay:) userInfo:nil repeats:YES];
//                [[NSRunLoop currentRunLoop] addTimer:myTimer forMode:NSDefaultRunLoopMode];
                break;
            }
            default:
            {
                strMsg = @"支付结果：失败！";
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle: strMsg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
        }
    } else  if ([resp isKindOfClass:[SendAuthResp class]]) {
        if (resp.errCode == 0)
        {
            NSLog(@"用户同意");
            SendAuthResp *aresp = (SendAuthResp *)resp;
            [self getAccessTokenWithCode:aresp.code];
        } else if (resp.errCode == -4) {
            NSLog(@"用户拒绝");
        } else if (resp.errCode == -2) {
            NSLog(@"用户取消");
        }
    }
}

#pragma mark - 微信  使用code获取access token
- (void)getAccessTokenWithCode:(NSString *)code
{
    NSString *urlString =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WX_APP_ID_JX,WX_APP_SECRET_JX,code];
    NSURL *url = [NSURL URLWithString:urlString];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *dataStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data){
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if ([dict objectForKey:@"errcode"]){
                    //获取token错误
                } else {
                    //存储AccessToken OpenId RefreshToken以便下次直接登陆
                    //AccessToken有效期两小时，RefreshToken有效期三十天
                    [[NSUserDefaults standardUserDefaults] setObject:[dict objectForKey:@"refresh_token"] forKey:kWeiXinRefreshToken];
                    [self getUserInfoWithAccessToken:[dict objectForKey:@"access_token"] andOpenId:[dict objectForKey:@"openid"]];
                }
            }
        });
    });
    /*
     正确返回
     "access_token" = “Oez*****8Q";
     "expires_in" = 7200;
     openid = ooVLKjppt7****p5cI;
     "refresh_token" = “Oez*****smAM-g";
     scope = "snsapi_userinfo";
     */
    /*
     错误返回
     errcode = 40029;
     errmsg = "invalid code";
     */
}


#pragma mark - 微信获取用户信息
- (void)getUserInfoWithAccessToken:(NSString *)accessToken andOpenId:(NSString *)openId
{
    NSString *urlString =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToken,openId];
    NSURL *url = [NSURL URLWithString:urlString];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *dataStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data)
            {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if ([dict objectForKey:@"errcode"])
                {
                    //AccessToken失效
                    [self getAccessTokenWithRefreshToken:[[NSUserDefaults standardUserDefaults]objectForKey:kWeiXinRefreshToken]];
                } else {
                    //获取需要的数据
                    // 存储到本地
//                    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//                    [manager POST:WeChatLaod parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                        NSDictionary *dict = responseObject;
//                        NSString *status = [dict objectForKey:@"status"];
//                        if ([status isEqualToString:@"1"]) {
//                            NSString *jx_token = [dict objectForKey:@"jx_token"];
//                            [[NSUserDefaults standardUserDefaults] setObject:jx_token forKey:@"jx_token"];
//                            [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationWXSTR object:nil];
//                        }
//                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                    }];
                }
            }
        });
    });
    /*
     city = ****;
     country = CN;
     headimgurl = "http://wx.qlogo.cn/mmopen/q9UTH59ty0K1PRvIQkyydYMia4xN3gib2m2FGh0tiaMZrPS9t4yPJFKedOt5gDFUvM6GusdNGWOJVEqGcSsZjdQGKYm9gr60hibd/0";  头像
     language = "zh_CN";
     nickname = “****"; 昵称
     openid = oo*********;
     privilege =     (
     );
     province = *****;
     sex = 1;
     unionid = “o7VbZjg***JrExs";   唯一的
     */
    
    /*
     错误代码
     errcode = 42001;
     errmsg = "access_token expired";
     */
}

#pragma mark - 微信  使用RefreshToken刷新AccessToken
- (void)getAccessTokenWithRefreshToken:(NSString *)refreshToken
{
    NSString *urlString =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@",WX_APP_ID_JX,refreshToken];
    NSURL *url = [NSURL URLWithString:urlString];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *dataStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data)
            {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if ([dict objectForKey:@"errcode"])
                {
                    //授权过期
                } else {
                    //重新使用AccessToken获取信息
                    [self getUserInfoWithAccessToken:[dict objectForKey:@"access_token"] andOpenId:[dict objectForKey:@"openid"]];
                }
            }
        });
    });
    /*
     "access_token" = “Oez****5tXA";
     "expires_in" = 7200;
     openid = ooV****p5cI;
     "refresh_token" = “Oez****QNFLcA";
     scope = "snsapi_userinfo,";
     */
    /*
     错误代码
     "errcode":40030,
     "errmsg":"invalid refresh_token"
     */
}



#pragma mark - 回定单查询确定微信支付成功
-(void)OrderToSureTheSuccessWeChatPay{
    WS(weakSelf);
    NSString *outTradeNo = [[NSUserDefaults standardUserDefaults] objectForKey:out_trade_no];
    [[JXRequestManager sharedNetWorkManager] WeChatPayGoodsWithOmSaleOrderHeaderId:outTradeNo Success:^(NSDictionary *orderDic) {
        NSLog(@"orderDic = ==  %@",orderDic);
        NSString *basePaymentStatusKey = [[orderDic objectForKey:@"data"] objectForKey:@"basePaymentStatusKey"];
        if ([basePaymentStatusKey isEqualToString:@"20"]) {
             UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"支付成功" delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
    } failture:^(NSString *errMsg) {
        
    }];
}

#pragma mark - 回定单查询确定支付宝支付成功
-(void)OrderToSureTheSuccessAliPay{
    NSString *outTradeNo = [[NSUserDefaults standardUserDefaults] objectForKey:out_trade_no];
    [[JXRequestManager sharedNetWorkManager] AliPayGoodsWithOmSaleOrderHeaderId:outTradeNo Success:^(NSDictionary *orderDic) {
        NSString *basePaymentStatusKey = [orderDic objectForKey:@"basePaymentStatusKey"];
        if ([basePaymentStatusKey isEqualToString:@"20"]) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"支付成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }    } failture:^(NSString *errMsg) {
        
    }];
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([url.description rangeOfString:@"wb3731403874"].length) {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }   else if  ([url.description rangeOfString:@"pay/?returnKey"].length) {
        //跳转到URL scheme中配置的地址
        return [WXApi handleOpenURL:url delegate:self];
    } else {
        return  [WXApi handleOpenURL:url delegate:self];
    }
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //如果极简SDK不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
    if ([url.host isEqualToString:@"safepay"]) {
        [self OrderToSureTheSuccessAliPay];
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic){
//            NSLog(@"alipay safepay result = %@", resultDic);
        }];
    }
    if ([url.host isEqualToString:@"platformapi"]) {//支付宝钱包快登授权返回authCode
        [self OrderToSureTheSuccessAliPay];
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic){
//            NSLog(@"alipay platformapi result = %@", resultDic);
        }];
    }
    
    if ([url.description rangeOfString:@"wb3731403874"].length) {
        return [WeiboSDK handleOpenURL:url delegate:self];
    } else if  ([url.description rangeOfString:@"pay/?returnKey"].length) {
        //跳转到URL scheme中配置的地址
        return [WXApi handleOpenURL:url delegate:self];
    } else {
        return  [WXApi handleOpenURL:url delegate:self];
    }
}


- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = NSLocalizedString(@"发送结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken)
        {
//            self.wbtoken = accessToken;
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
//            self.wbCurrentUserID = userID;
        }
        [alert show];
    }
//    else if ([response isKindOfClass:WBAuthorizeResponse.class])
//    {
//        NSString *title = NSLocalizedString(@"认证结果", nil);
//        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken],  NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                              otherButtonTitles:nil];
//        
//        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
//        self.wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
//        self.wbRefreshToken = [(WBAuthorizeResponse *)response refreshToken];
//        [alert show];
//    }
//    else if ([response isKindOfClass:WBPaymentResponse.class])
//    {
//        NSString *title = NSLocalizedString(@"支付结果", nil);
//        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.payStatusCode: %@\nresponse.payStatusMessage: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBPaymentResponse *)response payStatusCode], [(WBPaymentResponse *)response payStatusMessage], NSLocalizedString(@"响应UserInfo数据", nil),response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                              otherButtonTitles:nil];
//        [alert show];
//    }
//    else if([response isKindOfClass:WBSDKAppRecommendResponse.class])
//    {
//        NSString *title = NSLocalizedString(@"邀请结果", nil);
//        NSString *message = [NSString stringWithFormat:@"accesstoken:\n%@\nresponse.StatusCode: %d\n响应UserInfo数据:%@\n原请求UserInfo数据:%@",[(WBSDKAppRecommendResponse *)response accessToken],(int)response.statusCode,response.userInfo,response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                              otherButtonTitles:nil];
//        [alert show];
//    }
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
//    NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
//    NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
//    NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
//    NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

@end
