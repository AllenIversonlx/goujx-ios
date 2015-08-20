
//
//  ShopDetailViewController.m
//  HongDian
//
//  Created by 姜通 on 15/7/13.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "Config.h"
#import "SingleGoodsViewController.h"
#import "ShopDeatilModel.h"
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "JXRequestManager.h"
#import "ShopDeatilModel.h"
#import "ShopDetailImgaeModel.h"
#import "ShopDetailTableViewCell.h"
#import "ShopDetailHeaderView.h"
#import <Masonry/Masonry.h>


#define NUMBER_OF_ITEMS (IS_IPAD? 19: 12)
#define NUMBER_OF_VISIBLE_ITEMS (IS_IPAD? 19: 7)
#define ITEM_SPACING 210
#define INCLUDE_PLACEHOLDERS YES
#define ShopDetailCollectionView @"ShopDetailCollectionViewCell"
@interface ShopDetailViewController ()

@property (nonatomic, retain) UIVisualEffectView *effectview;
@property (nonatomic, retain) ShopDetailHeaderView *headView;
@property (nonatomic, retain) ShopDeatilModel *shopDetailModel;

@end

@implementation ShopDetailViewController


-(NSMutableArray *)shopDeatilDataArray
{
    if (!_shopDeatilDataArray) {
        _shopDeatilDataArray = [NSMutableArray array];
    }
    return _shopDeatilDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = self.nameString;
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), Screen_Height())];
    [self.view addSubview: backImageView];
    backImageView.layer.masksToBounds = YES;
    backImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.effectview];
    [self.view addSubview:self.tableView];

    _wrap = NO;
    
    [[JXRequestManager sharedNetWorkManager] RequestShopDetailWithidString:self.idString Success:^(NSDictionary *singledic) {
        self.shopDetailModel = [ShopDeatilModel objectWithKeyValues:singledic];
        NSArray *shopImageArray = self.shopDetailModel.mallSaleDetail;
        for (NSDictionary *imageDic in shopImageArray) {
            ShopDetailImgaeModel *deitailImageModel = [ShopDetailImgaeModel objectWithKeyValues:imageDic];
            [self.shopDeatilDataArray addObject:deitailImageModel];
        }
        NSDictionary *coverDic = self.shopDetailModel.cover;
        [backImageView sd_setImageWithURL:[NSURL URLWithString:[coverDic objectForKey:@"absoluteMediaUrl"]]];
        self.headView.shopDetailModel = self.shopDetailModel;
        [self.tableView reloadData];
        
     } failture:^(NSString *errMsg) {
        
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shopDeatilDataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    ShopDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ShopDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    ShopDetailImgaeModel *deitailImageModel = self.shopDeatilDataArray[indexPath.row];
    cell.shopDetailImageModel = deitailImageModel;
#pragma mark - 跳转到单个商品详情界面
    cell.shopDetailSelectBlock = ^(NSInteger tag, ShopDetailImgaeModel *imageModel){
        if (tag == 3) {
            SingleGoodsViewController *singelVC = [[SingleGoodsViewController alloc] init];
            singelVC.idString = imageModel.mallProductId;
            [self.navigationController pushViewController:singelVC animated:YES];
        }
    };
    
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Screen_Width();
}

#pragma mark - UITableView
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Height(), Screen_Width()) style:UITableViewStylePlain];
        _tableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        // scrollbar 不显示
        _tableView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.pagingEnabled = YES;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headView;
    }
    return _tableView;
}

-(ShopDetailHeaderView *)headView
{
    if (!_headView) {
        WS(weakSelf);
        _headView = [[ShopDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), Screen_Width()) WithShopDetailMode:self.shopDetailModel];
        _headView.transform = CGAffineTransformMakeRotation(M_PI / 2);
        _headView.shopDetailblock = ^(NSInteger tag){
//            if (tag == 1) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
//            }
        };
        _headView.backgroundColor = [UIColor clearColor];
    }
    return _headView;
}


 - (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


//模糊效果
- (UIVisualEffectView *)effectview
{
    if (_effectview == nil) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        _effectview.frame = [[UIScreen mainScreen] bounds];
        _effectview.contentView.alpha = 0.0;
    }
    return _effectview;
}

@end
