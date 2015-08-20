//
//  MyProfileOrderHeaderView.h
//  HongDian
//
//  Created by 姜通 on 15/8/19.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProfileOrderModel.h"

@interface MyProfileOrderHeaderView : UIView
@property (nonatomic, retain) MyProfileOrderModel *myProfileOrderModel;

@property (nonatomic, retain) UILabel *statusLabel;
@property (nonatomic, retain) UILabel *orderMoneyLabel;
@property (nonatomic, retain) UILabel *orderNumberLabel;
@end
