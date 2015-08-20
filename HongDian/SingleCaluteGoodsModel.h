//
//  SingleCaluteGoodsModel.h
//  HongDian
//
//  Created by 姜通 on 15/8/11.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleCaluteGoodsModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *mallProductId;
@property (nonatomic, copy) NSString *mallProductDescribeTypeKey;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *displayOrder;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, retain) NSDictionary *media;

@end
