//
//  SingleProductView.h
//  HongDian
//
//  Created by 姜通 on 15/7/29.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleProducrFrameModel.h"
#import "ResetButton.h"

typedef void(^ShareOrCollectionOrBuyCarBlock)(NSInteger clickTag);


@interface SingleProductView : UIView<UIScrollViewDelegate>
{
    NSUInteger count;
}

@property (nonatomic, retain) UILabel *produceLabel;
@property (nonatomic, retain) UIScrollView *headImageScrollView;
@property (nonatomic, retain) UIImageView *bigImageView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *priceLabel;
@property (nonatomic, retain) UILabel *detailLable;
@property (nonatomic, retain) SingleProducrFrameModel *frameModel;
@property (nonatomic, retain) UIPageControl *pageControl;

@property (nonatomic, copy) ShareOrCollectionOrBuyCarBlock share_colletion_buycarBlock;

@property (nonatomic, retain) ResetButton *buyCayButton;
@property (nonatomic, retain) ResetButton *collectionButton;
@property (nonatomic, retain) ResetButton *shareButton;



@end
