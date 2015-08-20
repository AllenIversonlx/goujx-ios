

//
//  ShopTableViewCell.m
//  HongDian
//
//  Created by 姜通 on 15/8/10.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "ShopTableViewCell.h"
#import "Config.h"
@implementation ShopTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.headimageView];
 
        [self.contentView addSubview:self.backImageView];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.readLabel];
        
        [self MasonryTheView];
    }
    return self;
}

-(void)setShopMainModel:(ShopMainModel *)shopMainModel
{
    NSDictionary *dic = shopMainModel.cover;
    [self.headimageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"absoluteMediaUrl"]]];
    self.contentLabel.text = shopMainModel.name;
    self.dateLabel.text = shopMainModel.displayDate;
    self.readLabel.text = [NSString stringWithFormat:@"%@人阅读",shopMainModel.readCount];
    
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.contentLabel.text];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    
//    [paragraphStyle setLineSpacing:10];//调整行间距
//    
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.contentLabel.text length])];
//    self.contentLabel.attributedText = attributedString;
//    [self.contentLabel sizeToFit];
}

-(void)MasonryTheView {
    WS(weakSelf);
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-30);
    }];
    
     [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
        make.left.equalTo(@15);
    }];
    
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(0);
        make.top.equalTo(weakSelf.contentLabel.mas_top);
        make.left.equalTo(weakSelf.mas_left).offset(0);
        make.right.equalTo(weakSelf.mas_right).offset(0);
    }];
    
    [_readLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
    }];
}

-(UIImageView *)headimageView {
    if (!_headimageView) {
        _headimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), Screen_Width() * 7 / 5)];
    }
    return _headimageView;
}

-(UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.font = [UIFont fontWithName:UserFont size:38];
        _contentLabel.numberOfLines = 0;
        [_contentLabel sizeToFit];
    }
    return _contentLabel;
}

-(UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.font = LittleTextLabelFont;
        _dateLabel.numberOfLines = 0;
    }
    return _dateLabel;
}

-(UILabel *)readLabel
{
    if (!_readLabel) {
        _readLabel = [[UILabel alloc] init];
        _readLabel.textColor = [UIColor whiteColor];
        _readLabel.backgroundColor = [UIColor clearColor];
        _readLabel.font = LittleTextLabelFont;
        _readLabel.numberOfLines = 0;
    }
    return _readLabel;
}

 - (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view
{
    CGRect rectInSuperview = [tableView convertRect:self.frame toView:view];
    
    float distanceFromCenter = CGRectGetHeight(view.frame)/2 - CGRectGetMinY(rectInSuperview);
    float difference = CGRectGetHeight(self.headimageView.frame) - CGRectGetHeight(self.frame);
    float move = (distanceFromCenter / CGRectGetHeight(view.frame)) * difference;
    
    CGRect imageRect = self.headimageView.frame;
    imageRect.origin.y = -(difference/2)+move;
    self.headimageView.frame = imageRect;
}

-(UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [UIImage imageNamed:@"maoboli"];
        _backImageView.contentMode = UIViewContentModeScaleToFill;
        _backImageView.layer.masksToBounds = YES;
    }
    return _backImageView;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
