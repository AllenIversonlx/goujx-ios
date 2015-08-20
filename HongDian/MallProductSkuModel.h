//
//  MallProductSkuModel.h
//  HongDian
//
//  Created by 姜通 on 15/8/4.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MallProductModel.h"
@interface MallProductSkuModel : NSObject

@property (nonatomic, copy) NSString *baseColor;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, retain) NSDictionary *mallProduct;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *mallProductId;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *sku;
@property (nonatomic, copy) NSString *status;


@property (nonatomic, retain) MallProductModel *mallProductModel;


@end
