//
//  ShopMainViewController.h
//  HongDian
//
//  Created by 姜通 on 15/7/13.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BaseViewController.h"
#import "ShopFirstViewController.h"
#import "ShopSecondViewController.h"
#import "ShopListViewController.h"

@interface ShopMainViewController : BaseViewController<UINavigationControllerDelegate>

@property (nonatomic ,strong) ShopFirstViewController  *firstVC;
@property (nonatomic ,strong) ShopSecondViewController *secondVC;
@property (nonatomic ,strong) ShopListViewController *shopListVC;

@property (nonatomic ,strong) UIViewController *currentVC;

@property (nonatomic ,strong) UIScrollView *headScrollView;  //  顶部滚动视图

@property (nonatomic ,strong) NSArray *headArray;


@property (nonatomic, strong) NSString *integerString;
@property (nonatomic, retain) ShopListView *shopListView;
@property (nonatomic, retain) NSMutableArray *dataArray;

@property (nonatomic, retain) NSString *refreshUrl;
@end
