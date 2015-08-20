//
//  MyOrderHeadView.h
//  HongDian
//
//  Created by 姜通 on 15/8/12.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderModel.h"

@interface MyOrderHeadView : UIView

@property (nonatomic, retain) UILabel *orderNameLabel;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UILabel *statusLabel;

@property (nonatomic, retain) MyOrderModel *orderModel;
@end
