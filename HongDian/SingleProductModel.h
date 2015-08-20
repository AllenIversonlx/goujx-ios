//
//  SingleProductModel.h
//  HongDian
//
//  Created by 姜通 on 15/7/29.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleProductModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *mallProductBrandId;
@property (nonatomic, copy) NSString *mallProductClassId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *describe;
@property (nonatomic, copy) NSString *detailDescribe;
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *originalPrice;
@property (nonatomic, copy) NSString *salePrice;
@property (nonatomic, copy) NSString *purchasePrice;
@property (nonatomic, copy) NSString *balancedCost;
@property (nonatomic, copy) NSString *deleteFlag;
@property (nonatomic, copy) NSString *deleteTimestamp;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *mallProductBrand;
@property (nonatomic, copy) NSString *mallProductCategory;
@property (nonatomic, copy) NSString *mallProductClass;
@property (nonatomic, copy) NSDictionary *cover;
@property (nonatomic, strong) NSArray *image;
@property (nonatomic, strong) NSArray *color;
@property (nonatomic, strong) NSArray *size;
@property (nonatomic, strong) NSDictionary *mallProductSkuMap;
@property (nonatomic, strong) NSDictionary *mallProductSkuStock;
@property (nonatomic, strong) NSArray *mallProductDescribe;


@end
