//
//  ShopTableViewCell.h
//  HongDian
//
//  Created by 姜通 on 15/8/10.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopMainModel.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface ShopTableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *headimageView;
@property (nonatomic, retain) UILabel *contentLabel;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UIImageView *backImageView;
@property (nonatomic, retain) UILabel *readLabel;

@property (nonatomic, retain) ShopMainModel *shopMainModel;
- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view;

@end
