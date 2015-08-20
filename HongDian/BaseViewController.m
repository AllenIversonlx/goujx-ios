//
//  LeftSaleViewController.h
//  HongDian
//
//  Created by 姜通 on 15/7/9.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BaseViewController.h"
#import "Config.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //默认隐藏tabbar
    self.navigationController.tabBarController.hidesBottomBarWhenPushed = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.text = @"锦向";
    _titleLabel.font = TextLabelFont;
    self.navigationItem.titleView = _titleLabel;

    self.view.backgroundColor = BackGroundColor;
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeFontColor, NSFontAttributeName: [UIFont systemFontOfSize:18]}];
    [self.navigationController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: ThemeFontColor, NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]} forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
