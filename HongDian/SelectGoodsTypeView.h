//
//  SelectGoodsTypeView.h
//  HongDian
//
//  Created by 姜通 on 15/7/23.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleProducrFrameModel.h"
#import "AddToCarView.h"
typedef void(^SureToBuyBlock)(NSString *mallProductSkuStockNumber, NSString *numberString);
typedef void(^DismissThePushViewBlock) ();

@interface SelectGoodsTypeView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UILabel *footerLabel;//显示库存数量
    NSString *selectSize;
    NSString *selectColor;
    int sku_code_number;
    UILabel *lb_showCount;//显示购买数量

}

@property (nonatomic, assign) CGRect newFrame;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *goodsSizeArray;
@property (nonatomic, strong) NSArray *goodsColorArray;
@property (nonatomic, strong) NSMutableArray *goodsNewColorArray;
@property (nonatomic, strong) NSDictionary *mallProductSkuMapDic;
@property (nonatomic, strong) NSDictionary *mallProductSkuStockDic;

@property (nonatomic, copy) DismissThePushViewBlock dismissThePushViewBlock;
@property (nonatomic, strong) AddToCarView *addView;
@property (nonatomic, retain) SingleProducrFrameModel *frameModel;
@property (nonatomic, retain) UIButton *sureButton;
@property (nonatomic, copy) SureToBuyBlock suretoBuyBlock;
@property (nonatomic, copy) NSString *mallProductSkuStockNumber;
@property (nonatomic, copy) NSString *mallProductSkuMapString;



-(instancetype)initWithFrame:(CGRect)frame andFrameModel:(SingleProducrFrameModel *)frameModel;

@end
