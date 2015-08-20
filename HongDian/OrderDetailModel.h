//
//  OrderDetailModel.h
//  HongDian
//
//  Created by 姜通 on 15/8/3.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailModel : NSObject

@property (nonatomic, copy) NSString *discountAmount;
@property (nonatomic, copy) NSString *discountRate;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *mallSaleDetailId;
@property (nonatomic, copy) NSString *mallProductSkuId;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, strong) NSArray *omSaleOrderHeaderId;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *quantity;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *subtotalAmount;
@property (nonatomic, copy) NSString *subtotalAmountBeforeTax;
@property (nonatomic, strong) NSArray *taxAmount;
@property (nonatomic, copy) NSString *taxRate;

@end
