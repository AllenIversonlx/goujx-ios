//
//  JXRenderBlurView.m
//  HongDian
//
//  Created by 姜通 on 15/7/28.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "JXRenderBlurView.h"
#import "Config.h"
#import "UIImage+ImageEffects.h"
#define JXBlurCollectionView @"JXBlurCollectionView"
#import "DRNRealTimeBlurView.h"
#import "PersonelHeaderView.h"
#import <SDWebImage/UIImageView+WebCache.h>


@implementation JXRenderBlurView


//模糊效果
- (UIVisualEffectView *)effectview
{
    if (_effectview == nil) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        _effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        _effectview.frame = [[UIScreen mainScreen] bounds];
        _effectview.contentView.alpha = 0.0;
    }
    return _effectview;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), Screen_Height())];
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        NSString *imageString = [[NSUserDefaults standardUserDefaults] objectForKey:PersonInformation];
        if (imageString) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageString]];
        } else {
            imageView.image = [UIImage imageNamed:@"golden-leaf"];
        }
        [self addSubview:imageView];
        [imageView addSubview:self.effectview];


        self.array = @[@{@"name":@"她说",@"image":@"sheSay_icon"},@{@"name":@"购物袋",@"image":@"buycar_icon"},@{@"name":@"其他",@"image":@"set_icon"}];
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
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    JXRenderBlurTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[JXRenderBlurTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell applyWithTitilString:[[self.array objectAtIndex:indexPath.row] objectForKey:@"name"]andIMageString:[[self.array objectAtIndex:indexPath.row] objectForKey:@"image"]];
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.clickTableCellBlock) {
        self.clickTableCellBlock(indexPath.row);
    }
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), Screen_Height()) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        PersonelHeaderView *personView = [[PersonelHeaderView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 230)];
        personView.backtomainBlock = ^(){
            if (self.toggleAction) {
                self.toggleAction(@"111");
            }
        };
        personView.changeheaderBlock = ^(NSInteger tag){
            if (self.clickThePersonBlock) {
                self.clickThePersonBlock(tag);
            }
        };
        _tableView.tableHeaderView = personView;
    }
    return _tableView;
}


@end
