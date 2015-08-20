


//
//  ShareModel.m
//  HongDian
//
//  Created by 姜通 on 15/8/7.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "ShareModel.h"
#import "JXRequestManager.h"

@implementation ShareModel
+ (instancetype)sharedTheMeaasg{
    static ShareModel *shareModelMessage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareModelMessage = [[[self class]alloc]init];
    });
    return shareModelMessage;
}

-(void)shareTheMessageToWBWithUrl:(NSString *)url AndTitle:(NSString *)title AndImage:(NSString *)imageString andDescription:(NSString *)description{
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = url;
    authRequest.scope = @"all";
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShareWithtitle:title andUrl:url andDescription:description andImageString:imageString] authInfo:authRequest access_token:nil];
    [WeiboSDK sendRequest:request];
}

- (WBMessageObject *)messageToShareWithtitle:(NSString *)title andUrl:(NSString *)url andDescription:(NSString *)description andImageString:(NSString *)imageString
{
    WBMessageObject *message = [WBMessageObject message];
    
    //    if (self.textSwitch.on)
    //    {
    //        message.text = NSLocalizedString(@"测试通过WeiboSDK发送文字到微博!", nil);
    //    }
    
    //    if (self.imageSwitch.on)
    //    {
    //        WBImageObject *image = [WBImageObject object];
    //        image.imageData = [NSData dataWithContentsOfFile:@"check_select"];
    //        message.imageObject = image;
    //    }
    
    //    if (self.mediaSwitch.on)
    //    {
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = @"JinXiang";
    webpage.title = NSLocalizedString(title, nil);
    webpage.description = [NSString stringWithFormat:NSLocalizedString(description, nil)];
    if (imageString != nil) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET:imageString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            //        webpage.thumbnailData = responseObject;
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    } else {
        webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
    }
    
    webpage.webpageUrl = url;
    message.mediaObject = webpage;
    //    }
    return message;
}


-(void)shareTheMessageToWeChatWithUrl:(NSString *)url AndTitle:(NSString *)title AndImage:(NSString *)imageString andDescription:(NSString *)description AndType:(NSString *)type{
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = title;
        message.description = description;
    
    if (imageString != nil) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET:imageString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            UIImage *image = [UIImage imageWithData:responseObject];
            [message setThumbImage:image];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
//        [message setThumbImage:[UIImage imageNamed:@"check_select"]];
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = url;
        message.mediaObject = ext;
        message.mediaTagName = title;
    
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
    if ([type isEqualToString:@"1"]) {
        req.scene = WXSceneSession;
    } else if ([type isEqualToString:@"2"]){
        req.scene = WXSceneTimeline;
    }
    
        [WXApi sendReq:req];
}


@end
