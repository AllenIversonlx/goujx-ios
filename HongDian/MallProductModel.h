//
//  MallProductModel.h
//  HongDian
//
//  Created by 姜通 on 15/8/4.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MallProductModel : NSObject

@property (nonatomic, copy) NSString *balancedCost;
@property (nonatomic, copy) NSDictionary *cover;
@property (nonatomic, retain) NSArray *color;
@property (nonatomic, copy) NSString *deleteFlag;
@property (nonatomic, copy) NSString *deleteTimestamp;
@property (nonatomic, copy) NSString *describe;
@property (nonatomic, copy) NSString *detailDescribe;

@property (nonatomic, copy) NSString *id;
@property (nonatomic, retain) NSArray *image;
@property (nonatomic, copy) NSString *mallProductBrandId;
@property (nonatomic, copy) NSString *mallProductBrand;
@property (nonatomic, copy) NSString *mallProductCategory;
@property (nonatomic, copy) NSString *mallProductClass;
@property (nonatomic, copy) NSString *mallProductClassId;


@property (nonatomic, retain) NSArray *mallProductSkuMap;
@property (nonatomic, retain) NSArray *mallProductSkuStock;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *originalPrice;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *purchasePrice;
@property (nonatomic, copy) NSString *salePrice;
@property (nonatomic, retain) NSArray *size;
@property (nonatomic, copy) NSString *status;

@end
