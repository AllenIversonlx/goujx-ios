//
//  HeadScrollView.h
//  HongDian
//
//  Created by 姜通 on 15/8/18.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TapTheScrollButtonBlock)(NSDictionary *dic);

@interface HeadScrollView : UIView

@property (nonatomic, retain) UIScrollView *scrollView;
-(instancetype)initWithFrame:(CGRect)frame WithArray:(NSArray *)array;

@property (nonatomic, retain) NSArray *dataArray;

@property (nonatomic, copy) TapTheScrollButtonBlock tapScrollButtonBlock;

@end
