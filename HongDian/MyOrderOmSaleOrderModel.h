//
//  MyOrderOmSaleOrderModel.h
//  HongDian
//
//  Created by 姜通 on 15/8/18.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderOmSaleOrderModel : NSObject
@property (nonatomic, copy) NSString *quantity;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, retain) NSDictionary *mallProductSku;

@end
