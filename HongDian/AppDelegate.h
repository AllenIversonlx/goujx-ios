//
//  AppDelegate.h
//  HongDian
//
//  Created by 姜通 on 15/7/9.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "WXApi.h"
#import <WeiboSDK/WeiboSDK.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,RESideMenuDelegate,WXApiDelegate,WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

