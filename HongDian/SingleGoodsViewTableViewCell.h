//
//  SingleGoodsViewTableViewCell.h
//  HongDian
//
//  Created by 姜通 on 15/8/11.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleGoodsFrameModel.h"


@interface SingleGoodsViewTableViewCell : UITableViewCell

@property (nonatomic, retain) UILabel *contentLabel;
@property (nonatomic, retain) UIImageView *produceImageView;

@property (nonatomic, retain) SingleGoodsFrameModel *frameModel;

@end
