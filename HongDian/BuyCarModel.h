//
//  BuyCarModel.h
//  HongDian
//
//  Created by 姜通 on 15/7/21.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MallProductSkuModel.h"

@interface BuyCarModel : NSObject

@property (nonatomic, copy) NSString *quantity;
@property (nonatomic, retain) NSDictionary *mallProductSku;
@property (nonatomic, copy) NSString *mallSaleDetail;

@end
