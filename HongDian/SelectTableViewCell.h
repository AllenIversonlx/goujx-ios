//
//  SelectTableViewCell.h
//  HongDian
//
//  Created by 姜通 on 15/7/22.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "AddressModel.h"

typedef void (^SelectAddressBlock)(UIButton *btn);

@interface SelectTableViewCell : UITableViewCell
@property (nonatomic, retain) UIView *view;
@property (nonatomic, retain) UILabel *peopleLabel;
@property (nonatomic, retain) UILabel *addressLabel;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UIButton *button;
@property (nonatomic, retain) UILabel *phoneLabel;
@property (nonatomic, copy) SelectAddressBlock selectAddressBlock;
@property (nonatomic, retain) AddressModel *addressModel;

@end
