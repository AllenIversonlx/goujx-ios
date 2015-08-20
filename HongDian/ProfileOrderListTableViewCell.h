//
//  ProfileOrderListTableViewCell.h
//  HongDian
//
//  Created by 姜通 on 15/8/18.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderOmSaleOrderModel.h"

@interface ProfileOrderListTableViewCell : UITableViewCell
@property (nonatomic, retain) UIImageView *headimageView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *moneyLabel;
@property (nonatomic, retain) UILabel *numberLabel;

@property (nonatomic, copy) NSString *mallProductSkuId;
@property (nonatomic, retain) MyOrderOmSaleOrderModel *myModel;
@property (nonatomic, retain) NSDictionary *dataDic;


@end
