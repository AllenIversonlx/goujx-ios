//
//  CouponModel.h
//  HongDian
//
//  Created by 姜通 on 15/8/18.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *discount;
@property (nonatomic, copy) NSString *expireTimestamp;
@property (nonatomic, copy) NSString *crmCouponStatus;


@end
