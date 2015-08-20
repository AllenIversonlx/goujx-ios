//
//  SingleProducrFrameModel.h
//  HongDian
//
//  Created by 姜通 on 15/7/29.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SingleProductModel.h"

@interface SingleProducrFrameModel : NSObject

@property (nonatomic, retain) SingleProductModel *singleProductModel;

@property (nonatomic, assign) CGFloat headImageheight;
@property (nonatomic, assign) CGRect headImageRect;

@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGFloat titleFloat;

@property (nonatomic, assign) CGFloat dateFloat;
@property (nonatomic, assign) CGRect dateRect;

@property (nonatomic, assign) CGRect produceRect;
@property (nonatomic, assign) CGFloat produceFloat;


@property (nonatomic, assign) CGFloat allHeight;


@end
