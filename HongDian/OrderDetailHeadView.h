//
//  OrderDetailHeadView.h
//  HongDian
//
//  Created by 姜通 on 15/8/13.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailHeadView : UIView

-(instancetype)initWithFrame:(CGRect)frame andWithMoney:(NSString *)money andOrderNumber:(NSString *)orderString andStatus:(NSString *)statusString;
@end
