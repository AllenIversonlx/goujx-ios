//
//  BuyCarTableViewCell.h
//  HongDian
//
//  Created by 姜通 on 15/7/21.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyCarModel.h"
#import "SingleProducrFrameModel.h"
#import "BuyCarModel.h"

typedef void (^DeleteOneGoodsBlock) (NSString *mallProductSkuId,NSString *lb_good_count,BuyCarModel *model,NSString *oneFees);
typedef void (^SelectGoodsBlock)( BOOL selected, NSString *totalFees);

typedef void (^AddOneGoodsBlock)(NSString *oneFees,NSString *mallProductSkuId,NSString *lb_good_count,BuyCarModel *model);
typedef void (^MinusOneGoodsBlock)(NSString *oneFees,NSString *mallProductSkuId,NSString *lb_good_count,BuyCarModel *model);

@interface BuyCarTableViewCell : UITableViewCell

#define CART_SHOW_CELL_HEIGHT          130
@property (nonatomic, assign) int goods_stock_number;//商品库存

@property (nonatomic, copy) DeleteOneGoodsBlock deleteGoodsBlock;

@property (nonatomic, copy) AddOneGoodsBlock addGoodsBlock;
@property (nonatomic, copy) MinusOneGoodsBlock minusGoodsBlock;

@property (nonatomic, copy) SelectGoodsBlock selectGoodsBlock;


@property (nonatomic, readonly,strong) UIButton *btn_check;


@property (nonatomic, retain) BuyCarModel *buyCarModel;
@property (nonatomic, copy) NSString *mallProductSkuId;
@property (nonatomic, strong) UIButton *btn_delete;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *littleView;
@property (nonatomic, strong) UIImageView *img_seperator;
@property (nonatomic, strong) UIImageView *img_goods_image;
@property (nonatomic, strong) UILabel *lb_goods_name;
@property (nonatomic, strong) UILabel *lb_goods_brand;
@property (nonatomic, strong) UILabel *lb_goods_price;
@property (nonatomic, strong) UIButton *btn_add_one;
@property (nonatomic, strong) UIButton *btn_minus_one;
@property (nonatomic, strong) UILabel *lb_goods_count;
@property (nonatomic, strong) UILabel *buyCountLabel;
@property (nonatomic, strong) UIView *bigView;
@property (nonatomic, assign) float totalfees;


- (void)applyModelValueWithModel:(BuyCarModel *)model andCount:(int)count;

//添加到结算
-(void)confirmToAdd:(UIButton *)btn;

//得到这个cell的数据
- (BuyCarModel *)getbuyCarModel;

@end
