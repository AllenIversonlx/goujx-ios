//
//  SingleGoodsView.h
//  HongDian
//
//  Created by 姜通 on 15/7/29.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleProductView.h"
#import "SingleProducrFrameModel.h"
#import "SingleProductView.h"
#import "SingleProductFooterTagView.h"
typedef void (^ClickShareOrCollectionBlock)(NSInteger tag);


@interface SingleGoodsView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) CGFloat headViewFloat;
@property (nonatomic, retain) SingleProducrFrameModel *productFrameModel;
@property (nonatomic, retain) SingleProductView *singleProductView;
@property (nonatomic, retain) UIScrollView *headImageScrollView;
@property (nonatomic, retain) SingleProductFooterTagView *footTagView;
@property (nonatomic ,retain) UITextView *textView;

@property (nonatomic, copy) ClickShareOrCollectionBlock clickShareOrCollectionBlock;

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *dataArray;

@property (nonatomic, retain) NSMutableArray *frameDataArray;

@end
