//
//  ShareModel.h
//  HongDian
//
//  Created by 姜通 on 15/8/7.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WXApi.h"
#import <WeiboSDK/WeiboSDK.h>

@interface ShareModel : NSObject

+ (instancetype)sharedTheMeaasg;


-(void)shareTheMessageToWBWithUrl:(NSString *)url AndTitle:(NSString *)title AndImage:(NSString *)imageString andDescription:(NSString *)description;


-(void)shareTheMessageToWeChatWithUrl:(NSString *)url AndTitle:(NSString *)title AndImage:(NSString *)imageString andDescription:(NSString *)description AndType:(NSString *)type;

@end
