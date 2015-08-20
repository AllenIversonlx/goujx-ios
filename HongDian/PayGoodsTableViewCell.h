//
//  PayGoodsTableViewCell.h
//  HongDian
//
//  Created by 姜通 on 15/7/22.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyCarModel.h"
@interface PayGoodsTableViewCell : UITableViewCell
#define CART_SHOW_CELL_HEIGHT          130

- (void)applyModelValueWithModel:(BuyCarModel *)model andCount:(int)count;

//添加到结算
//-(void)confirmToAdd:(UIButton *)btn;

//得到这个cell的数据
- (BuyCarModel *)getModel;

@end
