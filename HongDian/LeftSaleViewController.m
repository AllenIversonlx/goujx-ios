//
//  LeftSaleViewController.m
//  HongDian
//
//  Created by 姜通 on 15/7/9.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "LeftSaleViewController.h"
#import "ShopMainViewController.h"
#import "Config.h"
#import <Masonry/Masonry.h>

#define CollectionViewCellIdentifier   @"identifier"

@interface LeftSaleViewController ()

@end

@implementation LeftSaleViewController

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.itemSize = CGSizeMake(80, 100);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(60, 100, self.view.frame.size.width * 0.5, self.view.frame.size.height - 100) collectionViewLayout:flowLayout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource  = self;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return  _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = @[@"xxxx",@"xxxx",@"xxxx",@"xxxx",@"xxxx",@"xxxx",@"xxxx",@"xxxx"];
    self.view.backgroundColor = ThemeViewColor;
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] init];
    [cell.contentView addSubview:imageView];
    imageView.layer.borderColor = ThemeViewColor.CGColor;
    imageView.layer.borderWidth = 1;
    imageView.image = [UIImage imageNamed:@"111"];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.centerX.equalTo(cell.mas_centerX);
        make.width.equalTo(@25);
        make.height.equalTo(@20);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    [cell.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.right.equalTo(@-5);

        make.top.equalTo(imageView.mas_bottom).offset(10);
    }];
    label.font = [UIFont fontWithName:nil size:12];
    label.text = [self.array objectAtIndex:indexPath.row];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopMainViewController *shopMain = [[ShopMainViewController alloc] init];
//    shopMain.integerString = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    [self.sideMenuViewController
     setContentViewController:[[UINavigationController alloc] initWithRootViewController:shopMain] animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
