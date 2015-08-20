//
//  BaseViewController+JxViewAnimation.h
//  HongDian
//
//  Created by 姜通 on 15/8/6.
//  Copyright (c) 2015年 姜通. All rights reserved.
//
#define kSemiModalAnimationDuration   0.5

#import "BaseViewController.h"

@interface BaseViewController (JxViewAnimation)

-(void)presentSemiViewController:(BaseViewController*)vc;
-(void)presentSemiView:(UIView*)vc;
-(void)dismissSemiModalView;

@end
