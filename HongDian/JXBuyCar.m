//
//  JXBuyCar.m
//  HongDian
//
//  Created by 姜通 on 15/8/3.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "JXBuyCar.h"

@implementation JXBuyCar


+ (instancetype)sharedBuyWindow
{
    
    static JXBuyCar *buycar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        buycar = [[[self class] alloc] init];
        buycar.goodsArray = [NSMutableArray array];
    });
    return buycar;
}

@end
