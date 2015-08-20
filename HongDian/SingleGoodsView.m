
//
//  SingleGoodsView.m
//  HongDian
//
//  Created by 姜通 on 15/7/29.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "SingleGoodsView.h"
#import "Config.h"
#import "SingleProductFooterTagView.h"
#import "SingleGoodsViewTableViewCell.h"
#import "SingleCaluteGoodsModel.h"
#import "SingleGoodsFrameModel.h"
#import <MJExtension/MJExtension.h>
#import <Masonry/Masonry.h>

@implementation SingleGoodsView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.tableView];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.frameDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    SingleGoodsViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[SingleGoodsViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SingleGoodsFrameModel *frmaeModel = [self.frameDataArray objectAtIndex:indexPath.row];
    cell.frameModel = frmaeModel;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SingleGoodsFrameModel *mainframe = [self.frameDataArray objectAtIndex:indexPath.row];
    return mainframe.cellHeight;
}

#pragma mark - 使用set方法重新给数据进行赋值
-(void)setProductFrameModel:(SingleProducrFrameModel *)productFrameModel
{
    self.headViewFloat = productFrameModel.allHeight;

    self.singleProductView.frameModel = productFrameModel;
    self.dataArray = productFrameModel.singleProductModel.mallProductDescribe;
    for (NSDictionary *dic in self.dataArray) {
        SingleCaluteGoodsModel *singleModel = [SingleCaluteGoodsModel objectWithKeyValues:dic];
        SingleGoodsFrameModel *frame = [[SingleGoodsFrameModel alloc] init];
        frame.singleModel = singleModel;
        [self.frameDataArray addObject:frame];
    }
    
    [self.tableView reloadData];
}

#pragma  mark - 懒加载
-(SingleProductView *)singleProductView
{
    if (!_singleProductView) {
        _singleProductView = [[SingleProductView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 562)];
        _singleProductView.backgroundColor = [UIColor whiteColor];
        WS(weakSelf);
        _singleProductView.share_colletion_buycarBlock = ^(NSInteger tag){
            if (weakSelf.clickShareOrCollectionBlock) {
                weakSelf.clickShareOrCollectionBlock(tag);
            }
        };
    }
    return _singleProductView;
}

-(NSMutableArray *)frameDataArray{
    if (!_frameDataArray) {
        _frameDataArray = [NSMutableArray array];
    }
    return _frameDataArray;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), Screen_Height() - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 120;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.singleProductView;
    }
    return _tableView;
}


@end
