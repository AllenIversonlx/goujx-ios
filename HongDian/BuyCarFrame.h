//
//  BuyCarFrame.h
//  HongDian
//
//  Created by 姜通 on 15/7/21.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BuyCarModel.h"
#import <UIKit/UIKit.h>
@interface BuyCarFrame : NSObject

@property (nonatomic, retain) BuyCarModel *buyCarModel;

@property (nonatomic, assign) CGRect selectbuttonRect;
@property (nonatomic, assign) CGFloat selectbuttonFloat;

@property (nonatomic, assign) CGRect delectbuttonRect;
@property (nonatomic, assign) CGFloat delectbuttonFloat;

@property (nonatomic, assign) CGRect MessageRect;
@property (nonatomic, assign) CGFloat MessageFloat;

@property (nonatomic, assign) CGFloat headImageheight;
@property (nonatomic, assign) CGRect headImageRect;

@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGFloat titleFloat;

@property (nonatomic, assign) CGFloat moneyFloat;
@property (nonatomic, assign) CGRect moneyRect;

@property (nonatomic, assign) CGRect numberLabelRect;
@property (nonatomic, assign) CGFloat numberLabelFloat;

@property (nonatomic, assign) CGFloat miusFloat;
@property (nonatomic, assign) CGRect miusRect;

@property (nonatomic, assign) CGFloat addFloat;
@property (nonatomic, assign) CGRect addRect;

@property (nonatomic, assign) CGFloat numberFloat;
@property (nonatomic, assign) CGRect numberRect;

@property (nonatomic, assign) CGFloat sizeLabelFloat;
@property (nonatomic, assign) CGRect sizeLabelRect;
@property (nonatomic, assign) CGFloat colorLabelFloat;
@property (nonatomic, assign) CGRect colorLabelRect;


@property (nonatomic, assign) CGFloat allHeight;


@end
