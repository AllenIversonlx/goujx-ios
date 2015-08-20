//
//  ImageButton.h
//  HongDian
//
//  Created by Dave on 15/3/23.
//  Copyright (c) 2015年 HONG DIAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageButton : UIView


- (void)addTarget:(id)target andAction:(SEL)selector;

- (void)setTitle:(NSString *)title withFontSize:(CGFloat)fontSize andColor:(UIColor *)color;

@end
