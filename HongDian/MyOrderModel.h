//
//  MyOrderModel.h
//  HongDian
//
//  Created by 姜通 on 15/8/18.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *documentNum;
@property (nonatomic, copy) NSString *filingDate;
@property (nonatomic, copy) NSString *omSaleOrderHeaderStatus;
@property (nonatomic, copy) NSString *basePaymentStatus;
@property (nonatomic, retain) NSArray *omSaleOrderDetail;
@property (nonatomic, copy) NSString *displayStatus;


@end
