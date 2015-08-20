//
//  OrderDetailFootView.h
//  HongDian
//
//  Created by 姜通 on 15/8/13.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
#import "PayModel.h"
#import "CouponModel.h"
typedef void(^SelectTheAddressType)() ;
typedef void(^SelectThePayType)() ;
typedef void(^PayTheGoodsTypeBlock)();
typedef void(^SelectTheCouponTypeBlock)();

typedef void (^CancleTheOrderBlock)();

@protocol PayTheGoodsDelegate <NSObject>

//-(void)goToPayTheGoods;

@end

@interface OrderDetailFootView : UIView


@property (nonatomic, copy) SelectTheAddressType selectAddressType;
@property (nonatomic, copy) SelectThePayType selectPayType;
@property (nonatomic, copy) PayTheGoodsTypeBlock payTheGoodBlock;
@property (nonatomic, retain) AddressModel *addressModel;
@property (nonatomic, assign) id<PayTheGoodsDelegate>delegate;
@property (nonatomic, retain) PayModel *payModel;
@property (nonatomic, retain) NSDictionary *payDic;
@property (nonatomic, retain) UILabel *namelabel;
@property (nonatomic, retain) UILabel *phoneLabel;
@property (nonatomic, retain) UILabel *addressLabel;
@property (nonatomic, retain) CouponModel *couponModel;
@property (nonatomic, retain) UIImageView *payImageView;
@property (nonatomic, retain) UILabel *payLabel;
@property (nonatomic, copy) CancleTheOrderBlock cancleBolck;
@property (nonatomic, retain) UILabel *couponMoneyLabel;

@property (nonatomic, copy) SelectTheCouponTypeBlock selectTheCouponTypeBlock;
@end


