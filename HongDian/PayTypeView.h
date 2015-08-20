//
//  PayTypeView.h
//  HongDian
//
//  Created by 姜通 on 15/8/6.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectWeChatPayBlock)();
typedef void(^SelectAliPayBlock)();


@interface PayTypeView : UIView

@property (nonatomic, copy) SelectWeChatPayBlock wechatPayBlock;
@property (nonatomic, copy) SelectWeChatPayBlock aliPayBlock;


@end
