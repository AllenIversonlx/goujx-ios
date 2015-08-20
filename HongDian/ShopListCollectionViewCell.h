//
//  ShopListCollectionViewCell.h
//  HongDian
//
//  Created by 姜通 on 15/7/16.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopListModel.h"

@interface ShopListCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *contentLabel;
@property (nonatomic, retain) UILabel *dateLabel;

@property (nonatomic, retain) ShopListModel *shopListModel;

@end
