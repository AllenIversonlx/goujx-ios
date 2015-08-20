//
//  AlertShow.h
//  HongDian
//
//  Created by 姜通 on 15/7/28.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertShow : UIView

@property(retain,nonatomic)UIAlertView * alertview;

+(void)passwordError;

+(void)registerError;

+(void)changePwdError;

+(void)phoneError;

+(void)ImageError;


@end
