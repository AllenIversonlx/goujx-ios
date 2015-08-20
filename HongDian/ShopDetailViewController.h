//
//  ShopDetailViewController.h
//  HongDian
//
//  Created by 姜通 on 15/7/13.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BaseViewController.h"
#import <iCarousel/iCarousel.h>
#import "ShopDeatilModel.h"

//iCarouselDataSource, iCarouselDelegate,
@interface ShopDetailViewController : BaseViewController<UINavigationControllerDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
 @property (nonatomic, assign) BOOL wrap;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UITableView *tableView;

 @property (nonatomic, copy) NSString *idString;
@property (nonatomic, copy) NSString *nameString;

@property (nonatomic, retain) NSArray *items;

@property (nonatomic, retain) NSMutableArray *shopDeatilDataArray;
@property (nonatomic, retain) iCarousel *icarousel;

@end
