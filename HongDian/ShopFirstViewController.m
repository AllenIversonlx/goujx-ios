


//
//  ShopFirstViewController.m
//  HongDian
//
//  Created by 姜通 on 15/8/7.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "ShopFirstViewController.h"
#import "Config.h"
#import <Masonry/Masonry.h>
#import "ShopDetailViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "JXRequestManager.h"
#import <MJExtension/MJExtension.h>
#import "ShopMainModel.h"
#import "ShopTableViewCell.h"


@interface ShopFirstViewController ()

@end

@implementation ShopFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //第一次请求数据
    self.refreshUrl = ShopMainBaseUrl;
    [self RequestWithUrl:self.refreshUrl];
}

#pragma mark - 请求网络数据
-(void)RequestWithUrl:(NSString *)url{
    WS(weakSelf);
    if (url == nil) {
        [weakSelf.tableView.footer endRefreshing];

        return;
    }
    [[JXRequestManager sharedNetWorkManager] requestShopWithUrl:url MaimSaleAndSuccess:^(NSArray *items, NSDictionary *linksArray) {
        self.refreshUrl = [[linksArray objectForKey:@"next"] objectForKey:@"href"];
        for (NSDictionary *dic in items) {
            ShopMainModel *shopMainModel = [ShopMainModel objectWithKeyValues:dic];
            [weakSelf.dataArray addObject:shopMainModel];
        }
        [weakSelf.view addSubview:weakSelf.tableView];
        weakSelf.dataArray = weakSelf.dataArray;
        [weakSelf.tableView.footer endRefreshing];
        [weakSelf.tableView reloadData];
    } failture:^(NSString *errMsg) {
        NSLog(@"%@",errMsg);
        [weakSelf.tableView.footer endRefreshing];
        [weakSelf.tableView reloadData];
    }];
}

-(UITableView *)tableView
{
    if (!_tableView) {
        WS(weakSelf);
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), Screen_Height()) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
             [weakSelf RequestWithUrl:self.refreshUrl];
        }];
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    ShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ShopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.shopMainModel = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Screen_Width() * 7 /5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopMainModel *shopMainModel = [self.dataArray objectAtIndex:indexPath.row];
    NSString *idString = shopMainModel.id;
    NSString *name = shopMainModel.name;
    ShopDetailViewController *shopDetailVC = [[ShopDetailViewController alloc] init];
    shopDetailVC.nameString = name;
    shopDetailVC.idString = idString;
    [self.navigationController pushViewController:shopDetailVC animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Get visible cells on table view.
    NSArray *visibleCells = [self.tableView visibleCells];
    
    for (ShopTableViewCell *cell in visibleCells) {
        [cell cellOnTableView:self.tableView didScrollOnView:self.view];
    }
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}


-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
