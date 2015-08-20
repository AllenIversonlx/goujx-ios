//
//  SingleGoodsViewController.h
//  HongDian
//
//  Created by 姜通 on 15/7/20.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BaseViewController.h"
#import "SelectGoodsTypeView.h"
#import "ResetButton.h"
#import "SingleProductView.h"
#import "BuyCarViewController.h"
#import "JXBuyCar.h"
#import <Masonry/Masonry.h>
#import "SingleGoodsView.h"
#import "ShopBuyCarViewController.h"
#import "SingleBottomView.h"
#import "Config.h"
#import "WXApi.h"
#import <WeiboSDK/WeiboSDK.h>
#import "JXRequestManager.h"
#import "SingleProductModel.h"
#import <MJExtension/MJExtension.h>
#import "SingleProducrFrameModel.h"
#import "PayGoodsViewController.h"
#import "BaseViewController+JxViewAnimation.h"
#import "ShareModel.h"
#import "GuidanceLoginViewController.h"
#import "SingleProductFooterTagView.h"
#import "SingleGoodsViewTableViewCell.h"
#import "SingleCaluteGoodsModel.h"
#import "SingleGoodsFrameModel.h"


@interface SingleGoodsViewController : BaseViewController<UIScrollViewDelegate,UIWebViewDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, assign) CGFloat headViewFloat;
@property (nonatomic, copy) NSString *idString;
@property (nonatomic, retain) SingleProducrFrameModel *productFrameModel;
@property (nonatomic, retain) SingleProductView *singleProductView;
@property (nonatomic, retain) UIScrollView *headImageScrollView;
@property (nonatomic, retain) SingleProductFooterTagView *footTagView;
@property (nonatomic ,retain) UITextView *textView;
@property (nonatomic, assign) BOOL collectionType;
@property (nonatomic, copy) ClickShareOrCollectionBlock clickShareOrCollectionBlock;

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *dataArray;

@property (nonatomic, retain) NSMutableArray *frameDataArray;

@property (nonatomic, retain) UIView *beforeView;
//@property (nonatomic, assign) CGFloat headViewFloat;
@property (nonatomic, retain) SingleGoodsView *goodView;
@property (nonatomic, strong) SingleProducrFrameModel *frameModel;
@property (nonatomic, retain) SelectGoodsTypeView *selectTypeView;
//@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) SingleProductModel *singleModel;
@property (nonatomic, assign) NSInteger selectTag;

@end
