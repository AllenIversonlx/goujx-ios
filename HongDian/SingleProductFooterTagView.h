//
//  SingleProductFooterTagView.h
//  HongDian
//
//  Created by 姜通 on 15/7/29.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SKTagView/SKTagView.h>

@interface SingleProductFooterTagView : UIView

@property (nonatomic, strong) SKTagView *tagView;
@property (nonatomic, strong) UILabel *detailLable;
@property (nonatomic, strong) NSArray *ItemsArray;


@end
