//
//  AddressModel.h
//  HongDian
//
//  Created by 姜通 on 15/8/17.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject

/*
 address = 111111;
 id = 2;
 isDefault = 1;
 shippingToName = 123121;
 shippingToPhone = 15811083865;
 */
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *isDefault;
@property (nonatomic, copy) NSString *shippingToName;
@property (nonatomic, copy) NSString *shippingToPhone;



@end
