//
//  ShopDoBuyShareView.h
//  HongDian
//
//  Created by 姜通 on 15/8/13.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ShopDoBuViewBlock) (NSInteger tag);

@interface ShopDoBuyShareView : UIView

@property (nonatomic, retain) UIImageView *wrongImageView;
@property (nonatomic, retain) UIImageView *rightImageView;
@property (nonatomic, retain) UIImageView *buyImageView;
@property (nonatomic, retain) UIImageView *collectionImageView;
@property (nonatomic, retain) UIImageView *shareImageView;

@property (nonatomic, retain) UIButton *shareButton;


@property (nonatomic, copy) ShopDoBuViewBlock shopDoViewBlock;


@end
