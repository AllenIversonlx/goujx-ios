//
//  BuyCarViewController.m
//  HongDian
//
//  Created by 姜通 on 15/7/13.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BuyCarViewController.h"
#import "Config.h"
#import "BuyCarTableViewCell.h"
#import <Masonry/Masonry.h>
#import "PayGoodsViewController.h"
#import "JXBuyCar.h"
#import "JXRequestManager.h"
#import "BuyCarModel.h"
#import <MJExtension/MJExtension.h>
#import "Toast+UIView.h"
#import "OrderDetailViewController.h"
#import "GuidanceLoginViewController.h"

static NSString *kGoodsToBuyTableCellID = @"kGoodsToBuyTableCellID";

@interface BuyCarViewController ()
@property (nonatomic, assign) float totalFees;
@property (nonatomic, assign) float unselecterTotalFees;

@end

@implementation BuyCarViewController


#pragma mark - 获取第一次的数据
-(void)FirstRequestUrl{
    [[JXRequestManager sharedNetWorkManager] RequestListCarSuccess:^(NSArray *orderArray){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (NSDictionary *dic in orderArray) {
                BuyCarModel *buyCarModel = [BuyCarModel objectWithKeyValues:dic];
                [self.goodsArray addObject:buyCarModel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        });
    } failture:^(NSString *errMsg) {
        if ([errMsg isEqualToString:@"0"]) {
            GuidanceLoginViewController *guidelogin = [[GuidanceLoginViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:guidelogin];
            [self presentViewController:nav animated:YES completion:nil];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"购物车";
    [self FirstRequestUrl];
    [self.view addSubview:self.tableView];
    [self AddBottomView];
}

-(void)AddBottomView{
    _toolBarView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 128, Screen_Width(), 64)];
    _toolBarView.backgroundColor = [UIColor whiteColor];
    _toolBarView.layer.borderWidth = 1;
    _toolBarView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    _allCheckBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_allCheckBtn setImage:[UIImage imageNamed:@"selectedImage"] forState:UIControlStateSelected];
    [_allCheckBtn setImage:[UIImage imageNamed:@"unselectImage"] forState:UIControlStateNormal];
    [_allCheckBtn setTitle:@"全选" forState:UIControlStateNormal];
    _allCheckBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_allCheckBtn setTitleColor:BuyCarNameColor forState:UIControlStateNormal];
    [_allCheckBtn addTarget:self action:@selector(getAllGoodsSelected:) forControlEvents:UIControlEventTouchUpInside];
    [_allCheckBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [_allCheckBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    
    __weak __typeof(_toolBarView)toolBar = _toolBarView;
    [_toolBarView addSubview:_allCheckBtn];
    [_allCheckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(toolBar.mas_left).offset(10);
        make.centerY.equalTo(toolBar.mas_centerY);
        make.width.equalTo(@80);
    }];
    
//    self.totalFees = 0;
    _lb_totalFees = [[UILabel alloc]init];
    _lb_totalFees.textAlignment = NSTextAlignmentLeft;
    _lb_totalFees.textColor = ButtonColor;
    _lb_totalFees.text = [NSString stringWithFormat:@"合计: %@元", @"0"];
    [_toolBarView addSubview:self.lb_totalFees];

    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setTitle:@"去结算" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = TextLabelFont;
 
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmBtn.backgroundColor = ButtonColor;
    [confirmBtn addTarget:self action:@selector(confirmToSumb:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBarView addSubview:confirmBtn];
    
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(toolBar.mas_right).offset(0);
        make.centerY.equalTo(toolBar.mas_centerY);
        make.width.equalTo(@120);
        make.height.equalTo(@64);
    }];
    
    [self.lb_totalFees mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(confirmBtn.mas_left).offset(-10);
        make.centerY.equalTo(toolBar.mas_centerY);
    }];

    
    [self.view addSubview:_toolBarView];
}


#pragma mark - 去订单界面
- (void)confirmToSumb:(UIButton *)btn
{
    int selectedCount = [self confirmSelectedGoodsArray];
    
    if (selectedCount == 0) {
        [[self view] makeToast:@"请至少选择一件商品" duration:1 position:@"bottom"];
        return;
    }
//    [[JXRequestManager sharedNetWorkManager] createOmSaleOrderWithmallSaleDetailId:@"1" Success:^(NSString *omSaleOrderHeaderId) {
//        
//    } failture:^(NSString *errMsg) {
//        
//    }];
    
    OrderDetailViewController *payGoods = [[OrderDetailViewController alloc]init];
    payGoods.totalFees = self.totalFees;
    payGoods.goodsArray = self.selectedGoodsArray;
    [self.navigationController pushViewController:payGoods animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodsArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CART_SHOW_CELL_HEIGHT;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BuyCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kGoodsToBuyTableCellID];
    if (cell == nil) {
        cell = [[BuyCarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kGoodsToBuyTableCellID];
    }
    
    WS(weakSelf);
    
    __weak __typeof(&*cell) weakCell = cell;
    BuyCarModel *buyCarModel = [self.goodsArray objectAtIndex:indexPath.row];
    [cell applyModelValueWithModel:buyCarModel andCount:1];
    
    cell.minusGoodsBlock = ^(NSString *oneFees,NSString *mallProductSkuId,NSString *lb_good_count,BuyCarModel *model){
        [weakSelf actionDeleteFromCart:mallProductSkuId andGoodsCount:lb_good_count andModel:model];
        if (!weakCell.btn_check.selected) {
            self.unselecterTotalFees = 0;
            weakSelf.lb_totalFees.text = [NSString stringWithFormat:@"合计 %.2f元", weakSelf.unselecterTotalFees];
        } else {
            weakSelf.totalFees -= [oneFees floatValue];
            weakSelf.lb_totalFees.text = [NSString stringWithFormat:@"合计 %.2f元", weakSelf.totalFees];
        }
        [self checkTheCellButtonSelected];
    };
    
    cell.addGoodsBlock = ^(NSString *oneFees,NSString *mallProductSkuId,NSString *lb_good_count,BuyCarModel *model){
        [weakSelf actionDeleteFromCart:mallProductSkuId andGoodsCount:lb_good_count andModel:model];
        if (!weakCell.btn_check.selected) {
            self.unselecterTotalFees = 0;
            weakSelf.lb_totalFees.text = [NSString stringWithFormat:@"合计 %.2f元", weakSelf.unselecterTotalFees];
        } else {
            weakSelf.totalFees += [oneFees floatValue];
            weakSelf.lb_totalFees.text = [NSString stringWithFormat:@"合计 %.2f元", weakSelf.totalFees];
        }
        [self checkTheCellButtonSelected];
    };
    
    cell.selectGoodsBlock = ^(BOOL selected, NSString *oneGoodsTotalFees){
        if (selected) {
            weakSelf.totalFees += [oneGoodsTotalFees floatValue];
            weakSelf.lb_totalFees.text = [NSString stringWithFormat:@"合计 %.2f元", weakSelf.totalFees];
            if ([weakSelf confirmSelectedGoodsArray] != (int)weakSelf.goodsArray.count) {
                weakSelf.allCheckBtn.selected = NO;
            } else {
                weakSelf.allCheckBtn.selected = YES;
            }
        } else {
            weakSelf.allCheckBtn.selected = NO;//未选中
            weakSelf.totalFees -= [oneGoodsTotalFees floatValue];
            weakSelf.lb_totalFees.text = [NSString stringWithFormat:@"合计 %.2f元", weakSelf.totalFees];
        }
    };

//    cell.deleteGoodsBlock = ^(NSString *mallProductSkuId,NSString *goodsCount,BuyCarModel *model, NSString *oneFees){
//        goodsCount = @"-1";
//        if (cell.btn_check.selected == NO) {
//            
//        } else if (self.totalFees <= 0) {
//
//        } else {
//            weakSelf.totalFees -= [oneFees floatValue];
//        }
//        weakSelf.lb_totalFees.text = [NSString stringWithFormat:@"合计 %.2f元", weakSelf.totalFees];
//        
//        [weakSelf actionDeleteFromCart:mallProductSkuId andGoodsCount:goodsCount andModel:model];
//    };
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TRUE;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    BuyCarTableViewCell *cell =  (BuyCarTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
    BuyCarModel *buyCarModel = self.goodsArray[indexPath.row];
    MallProductSkuModel *productSkuModel = [MallProductSkuModel objectWithKeyValues:buyCarModel.mallProductSku];
    NSString *goodsCount = @"-1";
    [self actionDeleteFromCart:productSkuModel.id andGoodsCount:goodsCount andModel:buyCarModel];

    WS(weakSelf);
    if (cell.btn_check.selected == NO) {
    
    } else if (self.totalFees <= 0) {
    
    } else {
        weakSelf.totalFees -= [cell.lb_goods_count.text intValue]* cell.totalfees;
    }
    weakSelf.lb_totalFees.text = [NSString stringWithFormat:@"合计 %.2f元", weakSelf.totalFees];
}


#pragma mark - 判断有没有点击选择cell的button，如果有总钱数目不变
-(void)checkTheCellButtonSelected{
    for (int i = 0; i < self.goodsArray.count; i++) {
        BuyCarTableViewCell *cell = (BuyCarTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell.btn_check.selected) {
            self.lb_totalFees.text = [NSString stringWithFormat:@"合计 %.2f元", self.totalFees];
        }
    }
}

#pragma mark - 设置全选
-(void)getAllGoodsSelected:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {//选中的时候，商品 不选
        for (int i = 0; i < self.goodsArray.count; i++) {
            BuyCarTableViewCell *cell =  (BuyCarTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (!cell.btn_check.selected) {
                [cell confirmToAdd:cell.btn_check];
            }
        }
    } else {
        for (int i = 0; i < self.goodsArray.count; i++) {
            BuyCarTableViewCell *cell =  (BuyCarTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (cell.btn_check.selected) {
                [cell confirmToAdd:cell.btn_check];
            }
        }
    }
}

#pragma mark - 确定 选中 的goods列表
- (int)confirmSelectedGoodsArray
{
    //确定 选中 的goods列表
    WS(weakSelf);
    [weakSelf.selectedGoodsArray removeAllObjects];
    for (int i = 0; i < self.goodsArray.count; i++) {
        BuyCarTableViewCell *cell = (BuyCarTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell.btn_check.selected) {
            [self.selectedGoodsArray addObject:cell.buyCarModel];
        }
    }
    return (int)self.selectedGoodsArray.count;
}


#pragma mark - 删除一件商品
-(void)actionDeleteFromCart:(NSString *)mallProductSkuId andGoodsCount:(NSString *)lb_goods_count andModel:(BuyCarModel *)model{
    WS(weakSelf);
    [[JXRequestManager sharedNetWorkManager] DeleteFromCarWithMallProductSkuId:mallProductSkuId andGoodsCount:lb_goods_count Success:^(NSArray *orderArray) {
      [weakSelf.goodsArray removeAllObjects];
      [weakSelf FirstRequestUrl];
    } failture:^(NSString *errMsg) {
      
    }];
}

-(NSMutableArray *)goodsArray
{
    if (!_goodsArray) {
        _goodsArray = [NSMutableArray array];
    }
    return  _goodsArray;
}

-(NSMutableArray *)selectedGoodsArray
{
    if (!_selectedGoodsArray) {
        _selectedGoodsArray = [NSMutableArray array];
    }
    return  _selectedGoodsArray;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,Screen_Width(), Screen_Height() - 128) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

@end
