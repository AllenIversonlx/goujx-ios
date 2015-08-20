//
//  ShopMainModel.h
//  HongDian
//
//  Created by 姜通 on 15/7/28.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "ShopDeatilModel.h"

@interface ShopMainModel : NSObject

/*
 baseWeatherKey = 10;
 cover = "http://jx-dev.cdn.goujx.com/MallSaleHeader/cover/20150728/297d283c0d576e809e82b1f37f3246f7.png";
 describe = "\U8fd9\U662f\U4e00\U4e2a\U6d4b\U8bd5sale";
 displayDate = "2015-07-01";
 displayOrder = 10;
 endDate = "2015-07-29";
 id = 1;
 likeCount = 234;
 mallSaleDetail =     (
 {
 describe = "<null>";
 id = 1;
 mallProductId = "<null>";
 mallSaleHeaderId = 1;
 onSaleQty = "<null>";
 salePrice = "<null>";
 status = 1;
 }
 );
 name = "\U6d4b\U8bd5Sale";
 readCount = 4324;
 startDate = "2015-07-30";
 status = 1;
 },
  */
@property (nonatomic, copy) NSString *baseWeatherKey;
@property (nonatomic, copy) NSDictionary *cover;
@property (nonatomic, copy) NSString *describe;
@property (nonatomic, copy) NSString *displayDate;
@property (nonatomic, copy) NSString *displayOrder;
@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *likeCount;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *readCount;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, retain) NSArray *mallSaleDetail;

@property (nonatomic, retain) ShopDeatilModel *shopDetailModel;


@end
