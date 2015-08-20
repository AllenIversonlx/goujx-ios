//
//  MyVouponTableViewCell.h
//  HongDian
//
//  Created by 姜通 on 15/8/14.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponModel.h"

@interface MyVouponTableViewCell : UITableViewCell


@property (nonatomic, retain) UIView *backView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *numberLabel;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UILabel *statusLabel;

@property (nonatomic, retain) CouponModel *couponModel;
@end


