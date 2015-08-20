//
//  OrderModel.h
//  HongDian
//
//  Created by 姜通 on 15/8/3.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject


@property (nonatomic, copy) NSString *basePaymentStatusKey;
@property (nonatomic, copy) NSString *crmUserId;
@property (nonatomic, copy) NSString *documentNum;
@property (nonatomic, copy) NSString *filingDate;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, strong) NSArray *omSaleOrderDetail;
@property (nonatomic, copy) NSString *omSaleOrderHeaderChannelKey;
@property (nonatomic, copy) NSString *omSaleOrderHeaderStatusKey;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *targetShipDate;
@property (nonatomic, copy) NSString *totalAmount;
@property (nonatomic, strong) NSArray *wmsShipmentHeader;
@property (nonatomic, copy) NSString *totalQuantity;


@end
