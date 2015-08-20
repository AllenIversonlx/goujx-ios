//
//  ShopDetailImgaeModel.h
//  HongDian
//
//  Created by 姜通 on 15/7/30.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopDetailImgaeModel : NSObject

/*
 "id": 25,
 "mallSaleHeaderId": 22,
 "describe": "",
 "mallProductId": null,
 "salePrice": null,
 "onSaleQty": null,
 "displayOrder": 10,
 "status": 1,
 "image": "http://jx-dev.cdn.goujx.com/MallSaleDetail/image/20150730/ba567455ef9acc7f540a0d9a6963aea3.jpeg"
 */

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *mallSaleHeaderId;
@property (nonatomic, copy) NSString *describe;
@property (nonatomic, copy) NSString *mallProductId;
@property (nonatomic, copy) NSString *salePrice;
@property (nonatomic, copy) NSString *onSaleQty;
@property (nonatomic, copy) NSString *displayOrder;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSDictionary *image;

@end


