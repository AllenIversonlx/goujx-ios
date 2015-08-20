//
//  ShopMainViewController.m
//  HongDian
//
//  Created by 姜通 on 15/7/13.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "ShopMainViewController.h"
#import "RESideMenu.h"
#import "BuyCarViewController.h"
#import "Config.h"
#import <Masonry/Masonry.h>
#import "PayGoodsViewController.h"
#import "CouponViewController.h"
#import "JXRenderBlurView.h"
#import "PersonViewController.h"
#import "AnotherMoreViewController.h"
#import "GuidanceLoginViewController.h"
#import "HeaderView.h"
#import "ProfileLikeViewController.h"
#import "MyOrderViewController.h"
#import "Toast+UIView.h"


@interface ShopMainViewController ()

@property (nonatomic, retain) JXRenderBlurView *blurView;
@property (nonatomic, retain) UIVisualEffectView *effectview;
@property (nonatomic, assign) BOOL buttonSelecter;
@property (nonatomic, retain) UIImage *image;

@end

@implementation ShopMainViewController


//右侧个人菜单栏
-(void)PushPersonelView:(UIButton *)button{

}

#pragma mark - 出现左侧菜单栏
-(void)SelectTypeSale:(UIButton *)button{
    [self CreatThePersonInformation];
    [self getPersonInformation];
    __weak JXRenderBlurView *view = _blurView;
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGAffineTransform transform =   CGAffineTransformMakeScale(1, 1);
                         view.transform = transform;
                         view.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         view.alpha = 1;
                     }];
}

#pragma mark - 点击头部的滑动按钮
- (void)didClickHeadButtonAction:(UIButton *)button
{
    //  点击处于当前页面的按钮,直接跳出
    if ((self.currentVC == self.firstVC && button.tag == 100)||(self.currentVC == self.shopListVC && button.tag == 101)) {
        return;
    } else {
        //  展示2个,其余一样,自行补全噢
        switch (button.tag) {
            case 100:
                [self replaceController:self.currentVC newController:self.firstVC];
                break;
            case 101:
                [self replaceController:self.currentVC newController:self.shopListVC];
                break;
          
            default:
                break;
        }
    }
}

//  切换各个标签内容
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
        } else {
            self.currentVC = oldController;
        }
    }];
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self AddLeftAndRightButton];
    self.buttonSelecter = YES;
    self.titleLabel.text = @"锦向";
    
    self.headArray = SegmentArray;
    /**
     *   automaticallyAdjustsScrollViewInsets又被这个属性坑了
     */
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    WS(weakSelf);
    //头部按钮
    HeaderView *headView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, 150, 44) WithArray:SegmentArray];
    self.navigationItem.titleView = headView;
    headView.tapTheButtonBlock = ^(NSInteger tag,UIButton *btn){
        [weakSelf didClickHeadButtonAction:btn];
    };

    //创建视图
    self.firstVC = [[ShopFirstViewController alloc] init];
    [self.firstVC.view setFrame:CGRectMake(0, 0, Screen_Width(), Screen_Height())];
    [self addChildViewController:_firstVC];
    
    self.shopListVC = [[ShopListViewController alloc] init];
    [self.shopListVC.view setFrame:CGRectMake(0, 0, Screen_Width(), Screen_Height())];
//    self.secondVC = [[ShopSecondViewController alloc] init];
//    [self.secondVC.view setFrame:CGRectMake(0, 0, Screen_Width(), Screen_Height())];
    
    //  默认,第一个视图(你会发现,全程就这一个用了addSubview)
    [self.view addSubview:self.firstVC.view];
    self.currentVC = self.firstVC;
}


#pragma mark - 创建个人信息的界面
-(void)CreatThePersonInformation{
    WS(weakSelf);
    self.blurView = [[JXRenderBlurView alloc] initWithFrame:self.view.bounds];
    //    __weak JXRenderBlurView *view = _blurView;
    self.blurView.transform = CGAffineTransformMakeScale(3, 3);
    self.blurView.alpha = 0;
    self.blurView.toggleAction = ^(NSString *idString){
        [weakSelf hideTheView];
    };
    
    //左侧视图弹出的界面
    self.blurView.clickThePersonBlock = ^(NSInteger tag){
        [weakSelf hideTheView];
        if (tag == 2) {
            PersonViewController *perdonVC = [[PersonViewController alloc] init];
            [weakSelf.navigationController pushViewController:perdonVC animated:YES];
        } else if (tag == 1){
            if ([[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey]){
                ProfileLikeViewController *profileLike = [[ProfileLikeViewController alloc] init];
                [weakSelf.navigationController pushViewController:profileLike animated:YES];
            } else {
                //去登陆界面
                GuidanceLoginViewController *guidelogin = [[GuidanceLoginViewController alloc] init];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:guidelogin];
                [weakSelf presentViewController:nav animated:YES completion:nil];
            }
        }
    };
    
    self.blurView.clickTableCellBlock = ^(NSInteger clicktag){
        [weakSelf hideTheView];
        if (clicktag == 2) {
            AnotherMoreViewController *another=[[AnotherMoreViewController alloc]init];
            [weakSelf.navigationController pushViewController:another animated:YES];
        } else if (clicktag == 1) {
            BuyCarViewController *buyCar = [[BuyCarViewController alloc] init];
            [weakSelf.navigationController pushViewController:buyCar animated:YES];
        }
    };
    [self.navigationController.view addSubview:self.blurView];
}

#pragma mark - 隐藏主界面的view
-(void)hideTheView{
    __weak JXRenderBlurView *view = _blurView;
    [UIView animateWithDuration:0.3  delay:0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGAffineTransform transform = CGAffineTransformMakeScale(3, 3);
                         view.transform = transform;
                         view.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         view.alpha = 0;
                     }];

}

#pragma mark - 添加左右侧按钮
-(void)AddLeftAndRightButton{
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightBtn setBackgroundImage:[UIImage imageNamed:@"Rectangle"] forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(presentRightMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
//    //    [rightBtn addTarget:self action:@selector(PushPersonelView:) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn sizeToFit];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"Rectangle"] forState:UIControlStateNormal];
    //    [leftBtn addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn addTarget:self action:@selector(SelectTypeSale:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn sizeToFit];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

//模糊效果
- (UIVisualEffectView *)effectview
{
    if (_effectview == nil) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        _effectview.frame = [[UIScreen mainScreen] bounds];
        _effectview.contentView.alpha = 0.0;
    }
    return _effectview;
}

#pragma mark - 获取首页的个人信息的数据
-(void)getPersonInformation{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
    if (token) {
        [[JXRequestManager sharedNetWorkManager] GetPersonInformationsuccess:^(NSDictionary *dic) {
            if (![dic objectForKey:@"code"]) {
                NSString *imageString = [[dic objectForKey:@"avatar"] objectForKey:@"absoluteMediaUrl"];
                [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"omCrmCouponCount"] forKey:omCrmCouponCount];
                [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"omCrmUserLikeProduct"] forKey:omCrmUserLikeProduct];
                [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"omSaleOrderCount"] forKey:omSaleOrderCount];
                
                [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"name"] forKey:PersonName];
                [[NSUserDefaults standardUserDefaults] setObject:imageString forKey:PersonInformation];
            } else {
            }
            [self.blurView setNeedsDisplay];
        } failture:^(NSString *errMsg) {
            
        }];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
//    self.navigationController.delegate = self;
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == self) {
        self.navigationController.navigationBar.alpha = 1;
    } else {
        self.navigationController.navigationBar.alpha = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
