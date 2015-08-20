//
//  SelectGoodsTypeView.m
//  HongDian
//
//  Created by 姜通 on 15/7/23.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "SelectGoodsTypeView.h"
#import "AddToCarView.h"
#import "AddToCarView.h"
#import "Config.h"
#import "BuyCarViewController.h"
#import "UIButton+Utilis.h"
#import <Masonry/Masonry.h>
#import "Toast+UIView.h"

static NSString *kheaderIdentifier = @"kheaderIdentifier_";
static NSString *kfooterIdentifier = @"kfooterIdentifier_";
static NSString *kGoodsPropertyCollectionViewCellID = @"kGoodsPropertyCollectionViewCellID_";
static NSString *kGoodsNumberPropertyCollectionViewCellID = @"kGoodsNumberPropertyCollectionViewCellID";

#define Collection_Cell_Horizon_Margin        8
#define Collection_Cell_Vertical_Margin       10

@implementation SelectGoodsTypeView

-(instancetype)initWithFrame:(CGRect)frame andFrameModel:(SingleProducrFrameModel *)frameModel
{
    if (self = [super initWithFrame:frame]) {
        self.frameModel = frameModel;
//        self.goodsColorArray = @[@"红",@"黄",@"红",@"黄",@"黄"];
        self.mallProductSkuMapDic = frameModel.singleProductModel.mallProductSkuMap;
        self.goodsColorArray = frameModel.singleProductModel.color;
        self.goodsSizeArray = frameModel.singleProductModel.size;
        self.mallProductSkuStockDic = frameModel.singleProductModel.mallProductSkuStock;
        [self addSubview:self.collectionView];
        
//        //底部数量
//        footerLabel = [[UILabel alloc]init];
//        footerLabel.textAlignment = NSTextAlignmentLeft;
//        footerLabel.textColor = [UIColor lightGrayColor];
//        footerLabel.font = [UIFont systemFontOfSize:13];
        
        lb_showCount = [[UILabel alloc]init];
        lb_showCount.textAlignment = NSTextAlignmentCenter;
        lb_showCount.text = @"1";
        lb_showCount.frame = CGRectMake(33, 0, 33, 33);
        lb_showCount.textColor = [UIColor blackColor];
        lb_showCount.layer.borderColor = AddOrMiusColor.CGColor;
        lb_showCount.layer.borderWidth = 0.5;
        
        self.addView.frameModel = self.frameModel;
        [self addSubview:self.addView];
        [self addSubview:self.sureButton];
        
        [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@25);
            make.right.equalTo(@-25);
            make.height.equalTo(@60);
            make.bottom.equalTo(self.mas_bottom).offset(-75);
        }];
        
        [self reselectColorAndSize];
    }
    return self;
}

- (void)reselectColorAndSize
{
    //默认选中第一个
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:0];
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1] animated:NO scrollPosition:0];
    //查找出 颜色 和 大小
    selectColor = self.goodsColorArray.count ? self.goodsColorArray[0] : nil;
    selectSize = self.goodsSizeArray.count ? self.goodsSizeArray[0] : nil;

    if (!selectColor) {
        selectColor = @"";
    }
    if (!selectSize){
    selectSize = @"";
    }
    NSString *string = [NSString stringWithFormat:@"%@%@",selectColor,selectSize];
    
    sku_code_number = [self returnSelectSku_number:string];
    
    NSLog(@"%d",sku_code_number);
}


#pragma mark - 获取购物的数目
-(int)returnSelectSku_number:(NSString *)selectString{
    self.mallProductSkuMapString = [self.mallProductSkuMapDic objectForKey:selectString];
    self.mallProductSkuStockNumber = [self.mallProductSkuStockDic objectForKey: [NSString stringWithFormat:@"%@",self.mallProductSkuMapString]];
    return [self.mallProductSkuStockNumber intValue];
}


//头部的信息介绍
#pragma mark - 头部的信息介绍
-(AddToCarView *)addView
{
    if (!_addView) {
        WS(weakSelf);
        _addView = [[AddToCarView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 60)];
        _addView.canclePushViewBlock = ^(){
            if (weakSelf.dismissThePushViewBlock) {
                weakSelf.dismissThePushViewBlock();
            }
        };
    }
    return _addView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;//尺寸和颜色,数量
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 0://尺寸
        {
            return self.goodsSizeArray.count;
            break;
        }
        case 1://颜色
        {
            return  self.goodsColorArray.count;
            break;
        }
        case 2://数量
        {
            return 1;
            break;
        }

        default:
            break;
    }
    return 0;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]){
        reuseIdentifier = kheaderIdentifier;
        UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
        for (UIView *subview in view.subviews) {
            if ([subview isKindOfClass:[UILabel class]]) {
                [subview removeFromSuperview];
            }
        }
        UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor lightGrayColor];
        label.font = LittleTextLabelFont;
        switch (indexPath.section) {
            case 0:
            {
                label.text = @"尺码";
                break;
            }
            case 1:
            {
                label.text = @"颜色";
                break;
            }
            case 2:
            {
                label.text = @"数量";
                break;
            }
                
            default:
                break;
        }
        [view addSubview:label];
        return view;
    } else {
        reuseIdentifier = kfooterIdentifier;
        UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
        for (UIView *subview in view.subviews) {
            if ([subview isKindOfClass:[UILabel class]]) {
                [subview removeFromSuperview];
            }
        }
//        switch (indexPath.section) {
//            case 2:
//            {
//                footerLabel.frame = CGRectMake(0, 0, 120, 18);
//                [view addSubview:footerLabel];
//                footerLabel.text =  @"     库存";
////                if (self.goodsStockArray.count) {
//                    int skuNumber = 0;
////                    for (SKUModel *model in self.goodsStockArray) {
////                        skuNumber += [model.stock_num intValue];
////                    }
//                    footerLabel.text = [NSString stringWithFormat:@"%@: %d件",@"     库存", skuNumber];
////                    self.myStockNumber = skuNumber;
////                }
//                break;
//            }
//        
//            default:
//                break;
//        }
        return view;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        //数量，单独考虑
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGoodsNumberPropertyCollectionViewCellID forIndexPath:indexPath];
        
//        for (UIView *view in cell.subviews) {
//            if ([view isKindOfClass:[UILabel class]] || [view isKindOfClass:[UIButton class]]) {
//                [view removeFromSuperview];
//            }
//        }
        
        UIButton *btn_addOne = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_addOne.tag = 100;
        btn_addOne.frame = CGRectMake(0, 0, 33, 33);
        [btn_addOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn_addOne.backgroundColor = [UIColor whiteColor];
        btn_addOne.layer.borderColor = AddOrMiusColor.CGColor;
        btn_addOne.layer.borderWidth = 0.5;
        [btn_addOne setTitle:@"+" forState:UIControlStateNormal];
        
        UIButton *btn_minusOne = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_minusOne.tag = 200;
        btn_minusOne.backgroundColor = [UIColor whiteColor];
        btn_minusOne.layer.borderColor = AddOrMiusColor.CGColor;
        btn_minusOne.layer.borderWidth = 0.5;
        btn_minusOne.frame = CGRectMake(66, 0, 33, 33);
        [btn_minusOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn_minusOne setTitle:@"-" forState:UIControlStateNormal];
        
//        lb_showCount.frame = CGRectMake(33, 0, 33, 33);
        
        [cell addSubview:btn_addOne];
        [cell addSubview:lb_showCount];
        [cell addSubview:btn_minusOne];
        
        //actions
        [btn_addOne addTarget:self action:@selector(changeGoodsCount:) forControlEvents:UIControlEventTouchUpInside];
        [btn_minusOne addTarget:self action:@selector(changeGoodsCount:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }

    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGoodsPropertyCollectionViewCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.layer.borderWidth = 0.5;
    cell.layer.cornerRadius = 3;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.layer.masksToBounds = YES;
    UIView *backGroundView = [[UIView alloc] initWithFrame:cell.bounds];
    backGroundView.backgroundColor = ButtonColor;
    [cell setSelectedBackgroundView:backGroundView];
    for (UIView *view in cell.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    UILabel *label = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = LittleTextLabelFont;
    switch (indexPath.section) {
        case 0:
        {
            label.text = self.goodsSizeArray[indexPath.row];
            break;
        }
        case 1:
        {
            label.text = self.goodsColorArray[indexPath.row];
            break;
        }
        default:
            break;
    }
    [cell addSubview:label];
    return cell;
}

//增加 减少商品数量
- (void)changeGoodsCount:(UIButton *)btn
{
    switch (btn.tag) {
        case 100:
        {
            //增加
            int toBuyNum = [lb_showCount.text intValue];
            if (++toBuyNum > [self.mallProductSkuStockNumber intValue]) {
                [self makeToast:@"已经达到最大购买数量" duration:1 position:@"center"];
                return;
            }
            lb_showCount.text = [NSString stringWithFormat:@"%d", toBuyNum];
            
            break;
        }
        case 200:
        {
            //减少
            int toBuyNum = [lb_showCount.text intValue];
            if (--toBuyNum < 1) {
                [self makeToast:@"1件起够" duration:1 position:@"center"];
                return;
            }
            lb_showCount.text = [NSString stringWithFormat:@"%d", toBuyNum];
            break;
        }
        default:
            break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {//尺码
            for (int i = 0; i < self.goodsSizeArray.count; i++) {
                UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
                if (![cell isEqual:[collectionView cellForItemAtIndexPath:indexPath]]) {
                    [collectionView deselectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] animated:YES];
                }
            }
            //查找出 颜色 和 大小
            selectSize = self.goodsSizeArray[indexPath.row];
            NSLog(@"selectSize  = == =%@",selectSize);
            break;
        }
        case 1:
        {//颜色
            for (int i = 0; i < self.goodsColorArray.count; i++) {
                UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:1]];
                if (![cell isEqual:[collectionView cellForItemAtIndexPath:indexPath]]) {
                    [collectionView deselectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:1] animated:YES];
                }
            }
            //查找出 颜色 和 大小
//            selectColor = self.goodsColorArray[indexPath.row];
            selectColor = self.goodsColorArray[indexPath.row];
            NSLog(@"selectSize  = == =%@",selectColor);
            break;
        }
        default:
            break;
    }
    if (! selectColor) {
        selectColor = @"";
    }
    if (!selectSize) {
        selectSize = @"";
    }
    NSString *string = [NSString stringWithFormat:@"%@%@",selectColor,selectSize];
    sku_code_number = [self returnSelectSku_number:string];
    NSLog(@"sku_code_number = == %d",sku_code_number);
//    NSLog(@"string  == = %@",string);
//    self.mallProductSkuMapString = [self.mallProductSkuMapDic objectForKey:@"string"];
//    self.mallProductSkuStockNumber = [self.mallProductSkuStockDic objectForKey:self.mallProductSkuMapString];
//    
//    NSLog(@"self.mallProductSkuStockNumber2  ==  %@",self.mallProductSkuStockNumber );
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        //数量
        return CGSizeMake(150, 40);
    }
    return  CGSizeMake(63, 26);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return CGSizeMake(Screen_Width(), 0);
    }
    return CGSizeMake(0, 0);
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.headerReferenceSize = CGSizeMake(Screen_Width(), 50);
        
        flowLayout.minimumInteritemSpacing = Collection_Cell_Horizon_Margin;
        flowLayout.minimumLineSpacing = Collection_Cell_Vertical_Margin;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 60, Screen_Width() - 20, Screen_Height()* 0.7 - 75 - 64) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        
        //允许多选
        _collectionView.allowsMultipleSelection = YES;
        //默认选中第一个
        [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:0];
        [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1] animated:NO scrollPosition:0];
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kGoodsPropertyCollectionViewCellID];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kGoodsNumberPropertyCollectionViewCellID];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
//        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kfooterIdentifier];
    }
    return _collectionView;
}


-(void)sureToBuy:(UIButton *)brn{
    if (self.suretoBuyBlock) {
        self.suretoBuyBlock(self.mallProductSkuMapString, lb_showCount.text);
    }
}


-(UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithTitleString:@"确定"];
        [_sureButton addTarget:self action:@selector(sureToBuy:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

@end
