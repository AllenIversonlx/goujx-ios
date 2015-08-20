//
//  ShopDetailHeaderView.h
//  HongDian
//
//  Created by 姜通 on 15/8/13.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDeatilModel.h"
#import "ShopDoBuyShareView.h"
typedef void (^ShopDetailHeaderViewBlock)(NSInteger tag);

@interface ShopDetailHeaderView : UIView

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *contentLable;
@property (nonatomic, retain) UIImageView *rightImageView;
@property (nonatomic, retain) UILabel *readLabel;
@property (nonatomic, retain) UILabel *favLabel;
@property (nonatomic, retain) ShopDoBuyShareView *shopDoView;

@property (nonatomic, copy) ShopDetailHeaderViewBlock shopDetailblock;
@property (nonatomic, retain) ShopDeatilModel *shopDetailModel;
-(instancetype)initWithFrame:(CGRect)frame WithShopDetailMode:(ShopDeatilModel *)shopdetailModel;


@end
