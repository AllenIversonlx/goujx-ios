//
//  MyOrderTableViewCell.h
//  HongDian
//
//  Created by 姜通 on 15/8/12.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyCarModel.h"

@interface MyOrderTableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *headimageView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *moneyLabel;
@property (nonatomic, retain) UILabel *numberLabel;

- (void)applyModelValueWithModel:(BuyCarModel *)model andCount:(int)count;
@property (nonatomic, retain) BuyCarModel *buyCarModel;
@property (nonatomic, copy) NSString *mallProductSkuId;

- (BuyCarModel *)getbuyCarModel;

@end
