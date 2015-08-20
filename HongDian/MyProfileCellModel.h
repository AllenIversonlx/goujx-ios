//
//  MyProfileCellModel.h
//  HongDian
//
//  Created by 姜通 on 15/8/19.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyProfileCellModel : NSObject

@property (nonatomic, copy) NSString *quantity;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, retain) NSDictionary *mallProductSku;

@end
