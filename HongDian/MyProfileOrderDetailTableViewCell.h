//
//  MyProfileOrderDetailTableViewCell.h
//  HongDian
//
//  Created by 姜通 on 15/8/19.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProfileCellModel.h"

@interface MyProfileOrderDetailTableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *headimageView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *myMoneyLabel;
@property (nonatomic, retain) UILabel *numberLabel;

//- (void)applyModelValueWithModel:(MyProfileCellModel *)model andCount:(int)count;
@property (nonatomic, retain) MyProfileCellModel *profileCellModel;
@property (nonatomic, copy) NSString *mallProductSkuId;

//- (MyProfileCellModel *)getbuyCarModel;

@end
