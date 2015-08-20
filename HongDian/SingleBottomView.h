//
//  SingleBottomView.h
//  HongDian
//
//  Created by 姜通 on 15/7/21.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleProducrFrameModel.h"
typedef void(^TapButtonViewBlock)(NSInteger tag);

@interface SingleBottomView : UIView

@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UILabel *priceLabel;
@property (nonatomic, retain) UILabel *label2;
@property (nonatomic, retain) UILabel *newPriceLabel;
@property (nonatomic, retain) UIButton *addtoCarButton;
@property (nonatomic, retain) UIButton *buyNowButton;


@property (nonatomic, copy) TapButtonViewBlock tapButtonBlock;

@property (nonatomic, retain) SingleProducrFrameModel *frameModel;

@end
