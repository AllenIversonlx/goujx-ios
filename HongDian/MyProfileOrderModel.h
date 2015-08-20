//
//  MyProfileOrderModel.h
//  HongDian
//
//  Created by 姜通 on 15/8/19.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyProfileOrderModel : NSObject


@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *documentNum;
@property (nonatomic, copy) NSString *filingDate;
@property (nonatomic, copy) NSString *omSaleOrderHeaderStatus;
@property (nonatomic, copy) NSString *basePaymentStatus;
@property (nonatomic, copy) NSString *displayStatus;
@property (nonatomic, retain) NSArray *omSaleOrderDetail;
@property (nonatomic, retain) NSArray *wmsShipmentHeader;
@property (nonatomic, retain) NSString *totalAmount;
@property (nonatomic, retain) NSDictionary *omSaleOrderPayment;
@property (nonatomic, retain) NSDictionary *crmCoupon;

@end
