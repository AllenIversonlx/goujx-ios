

//
//  AnotherMoreViewController.m
//  HongDian
//
//  Created by 姜通 on 15/8/10.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "AnotherMoreViewController.h"
#import "PersonTableViewCell.h"
#import "Config.h"
#import <Masonry/Masonry.h>
#import "UIButton+Utilis.h"
#import <SDWebImage/SDImageCache.h>
#import "PayModel.h"
#import <MJExtension/MJExtension.h>
#import "Toast+UIView.h"
#import "AboutUsViewController.h"
#import "ContentUsViewController.h"

@interface AnotherMoreViewController ()

@property (nonatomic, retain) NSMutableArray *dataArray;

@end

@implementation AnotherMoreViewController



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"其他";
    self.array = @[@{@"name":@"清除缓存",@"image":@"clear_icon"},@{@"name":@"给锦向打分吧",@"image":@"score_icon"},@{@"name":@"关于锦向",@"image":@"about"},@{@"name":@"联系我们",@"image":@"relaiveus_icon"}];
    for (NSDictionary *dic in self.array) {
        PayModel *payModel = [PayModel objectWithKeyValues:dic];
        [self.dataArray addObject:payModel];
    }
    
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    PersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[PersonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.payModel = self.dataArray[indexPath.row];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            [[SDImageCache sharedImageCache] clearDisk];
            [[SDImageCache sharedImageCache] clearMemory];
            
            [[self view] makeToast:@"清除缓存成功" duration:1 position:@"bottom"];
            break;
        }
        case 1: {
        
            break;
        }
        case 2 :{
            AboutUsViewController *aboutVC = [[AboutUsViewController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
            break;
        }
        case 3:{
            ContentUsViewController *contentVC = [[ContentUsViewController alloc] init];
            [self.navigationController pushViewController:contentVC animated:YES];
            break;
        }
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), Screen_Height()) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}



@end
