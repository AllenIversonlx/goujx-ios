//
//  MyProfileFooterView.h
//  HongDian
//
//  Created by 姜通 on 15/8/19.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProfileOrderModel.h"

@interface MyProfileFooterView : UIView


@property (nonatomic, retain) NSDictionary *payDic;
@property (nonatomic, retain) UILabel *namelabel;
@property (nonatomic, retain) UILabel *phoneLabel;
@property (nonatomic, retain) UILabel *addressLabel;
@property (nonatomic, retain) UILabel *orderDipectionLabel;
@property (nonatomic, retain) UILabel *couponMoneyLabel;

@property (nonatomic, retain) UIImageView *payImageView;
@property (nonatomic, retain) UILabel *payLabel;
@property (nonatomic, retain) MyProfileOrderModel *myProfileOrderModel;

@end
