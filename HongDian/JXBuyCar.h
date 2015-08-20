//
//  JXBuyCar.h
//  HongDian
//
//  Created by 姜通 on 15/8/3.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXBuyCar : NSObject

@property (nonatomic, strong) NSMutableArray *goodsArray;//加入购物车的商品

+ (instancetype)sharedBuyWindow;

@end
