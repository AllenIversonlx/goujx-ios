//
//  ShopDetailTableViewCell.h
//  HongDian
//
//  Created by 姜通 on 15/8/13.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "Config.h"
#import "ShopDetailImgaeModel.h"
#import "ShopDoBuyShareView.h"
typedef void(^ShopDetailSelectBlock)(NSInteger tag,ShopDetailImgaeModel *model);


@interface ShopDetailTableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) UIImageView *imageShodow;
@property (nonatomic, retain) ShopDoBuyShareView *shopDoView;
@property (nonatomic, copy) ShopDetailSelectBlock shopDetailSelectBlock;

-(ShopDetailImgaeModel *)getImageModel;

@property (nonatomic, retain) ShopDetailImgaeModel *shopDetailImageModel;
@end
