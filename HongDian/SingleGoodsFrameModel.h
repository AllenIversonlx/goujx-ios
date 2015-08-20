//
//  SingleGoodsFrameModel.h
//  HongDian
//
//  Created by 姜通 on 15/8/11.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SingleCaluteGoodsModel.h"

@interface SingleGoodsFrameModel : NSObject

@property (nonatomic, retain) SingleCaluteGoodsModel *singleModel;
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGRect textFrame;
@property (nonatomic, assign) CGRect imageFrame;

@end

