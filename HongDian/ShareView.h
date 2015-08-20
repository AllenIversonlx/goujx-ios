//
//  ShareView.h
//  HongDian
//
//  Created by 姜通 on 15/8/20.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^WechatFriendBlock) ();
typedef void(^WechatGroupBlock) ();
typedef void(^SinaShareBlock) ();
typedef void(^CancleShareBlock) ();


@interface ShareView : UIView

@property (nonatomic, copy) WechatFriendBlock wechatFriendblock;
@property (nonatomic, copy) WechatGroupBlock wechatgroupblock;
@property (nonatomic, copy) SinaShareBlock sinaShareBlock;
@property (nonatomic, copy) CancleShareBlock cancleblock;

@end
