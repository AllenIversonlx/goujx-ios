

//
//  PersonelHeaderView.m
//  HongDian
//
//  Created by 姜通 on 15/8/10.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "PersonelHeaderView.h"
#import "Config.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>


@implementation PersonelHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.headImageView];
        [self addSubview:self.messageImageView];
        [self addSubview:self.moreImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.deleteImageView];
        [self setUI];
    }
    return self;
}

//关闭当前界面
-(void)deleteThePersonel{
    if (self.backtomainBlock) {
        self.backtomainBlock();
    }
}

//去个人中心
-(void)changtheHeadImage:(UITapGestureRecognizer *)tap{
    UIImageView *imageView = (UIImageView *)[tap view];
    if (self.changeheaderBlock) {
        self.changeheaderBlock(imageView.tag);
    }
}

-(void)setUI{
    WS(weakSelf);
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(55);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.width.equalTo(@85);
        make.height.equalTo(@85);
    }];
    
    [_messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.headImageView.mas_centerY);
        make.right.equalTo(_headImageView.mas_left).equalTo(@-20);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];
    
    [_moreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.headImageView.mas_centerY);
        make.left.equalTo(_headImageView.mas_right).equalTo(@20);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];
    
    [_deleteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(35);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.width.equalTo(@17);
        make.height.equalTo(@17);
    }];
    
     [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerX.equalTo(weakSelf.mas_centerX);
         make.top.equalTo(weakSelf.headImageView.mas_bottom).offset(10);
     }];
}

-(UIImageView *)headImageView
{
    if (!_headImageView ) {
        _headImageView = [[UIImageView alloc] init];
        NSString *imageString = [[NSUserDefaults standardUserDefaults] objectForKey:PersonInformation];
        if (imageString) {
            [_headImageView sd_setImageWithURL:[NSURL URLWithString:imageString]];
        } else {
            _headImageView.image = [UIImage imageNamed:@"personImageHeader"];
        }
        _headImageView.layer.cornerRadius = 85/2;
        _headImageView.userInteractionEnabled = YES;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.tag = 1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changtheHeadImage:)];
        [_headImageView addGestureRecognizer:tap];
    }
    return _headImageView;
}

-(UIImageView *)messageImageView
{
    if (!_messageImageView ) {
        _messageImageView = [[UIImageView alloc] init];
        _messageImageView.image = [UIImage imageNamed:@"message_icon"];
        _messageImageView.layer.cornerRadius = 20;
    }
    return _messageImageView;
}

-(UIImageView *)moreImageView
{
    if (!_moreImageView ) {
        _moreImageView = [[UIImageView alloc] init];
        _moreImageView.image = [UIImage imageNamed:@"more_icon"];
        _moreImageView.layer.cornerRadius = 20;
        _moreImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changtheHeadImage:)];
        _moreImageView.tag = 2;
        [_moreImageView addGestureRecognizer:tap];
    }
    return _moreImageView;
}

-(UIImageView *)deleteImageView
{
    if (!_deleteImageView ) {
        _deleteImageView = [[UIImageView alloc] init];
        _deleteImageView.image = [UIImage imageNamed:@"delete"];
        _deleteImageView.userInteractionEnabled = YES;
        _deleteImageView.tag = 3;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteThePersonel)];
        [_deleteImageView addGestureRecognizer:tap];
    }
    return _deleteImageView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = TextLabelFont;
        NSString *nameString = [[NSUserDefaults standardUserDefaults] objectForKey:PersonName];
        if (nameString || [nameString isEqualToString:@"Unauthorized"]) {
            _nameLabel.text = nameString;
        } else {
            _nameLabel.text = @"锦向";
        }
    }
    return _nameLabel;
}


//重写此方法 为了 让左上角的 选择按钮 更加 好 点击
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGRect rect = CGRectMake(self.frame.size.width - 60, 35, 40, 40);
    CGPoint point = [[touches anyObject]locationInView:self];
    if (CGRectContainsPoint(rect, point)) {
        [self deleteThePersonel];
        return;
    }
    //如果不调用super方法，tableView的代理方法不会响应
    [super touchesBegan:touches withEvent:event];
}


@end
