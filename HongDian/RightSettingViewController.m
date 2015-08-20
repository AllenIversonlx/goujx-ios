
//
//  RightSettingViewController.m
//  HongDian
//
//  Created by 姜通 on 15/7/9.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "RightSettingViewController.h"
#import "ShopMainViewController.h"
#import <Masonry/Masonry.h>
#import "Config.h"

#define CollectionViewIdentifier   @"collectionIdentifier"
#define CollectionHeaderViewIdentifier   @"collectionHeaderIdentifier"

@interface RightSettingViewController ()

@end

@implementation RightSettingViewController

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.itemSize = CGSizeMake(self.view.frame.size.width * 0.35, 100);
        flowLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width * 0.5, 140);

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.3, 40, self.view.frame.size.width * 0.7, self.view.frame.size.height - 40) collectionViewLayout:flowLayout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CollectionViewIdentifier];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CollectionHeaderViewIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource  = self;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return  _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ThemeViewColor;
    self.array = SettingArray;
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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewIdentifier forIndexPath:indexPath];
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
    shopMain.integerString = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    [self.sideMenuViewController
     setContentViewController:[[UINavigationController alloc] initWithRootViewController:shopMain] animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:CollectionHeaderViewIdentifier forIndexPath:indexPath];
        UIView *imageView = [[UIView alloc] init];
        [view addSubview:imageView];
        imageView.layer.cornerRadius = 25;
        imageView.layer.borderColor = ThemeViewColor.CGColor;
        imageView.layer.borderWidth = 1;
        imageView.backgroundColor = [UIColor whiteColor];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view.mas_centerX);
            make.top.equalTo(@10);
            make.width.equalTo(@50);
            make.height.equalTo(@50);
        }];
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.text = @"xxxx";
        [view addSubview:nameLabel];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view.mas_centerX);
            make.top.equalTo(imageView.mas_bottom).offset(5);
        }];
        reusableview = view;
    }
    return reusableview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
