


//
//  SingleGoodsViewTableViewCell.m
//  HongDian
//
//  Created by 姜通 on 15/8/11.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "SingleGoodsViewTableViewCell.h"
#import "Config.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation SingleGoodsViewTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.produceImageView];
    }
    return self;
}

-(void)setFrameModel:(SingleGoodsFrameModel *)frameModel
{
    self.contentLabel.frame = frameModel.textFrame;
    self.produceImageView.frame = frameModel.imageFrame;
    if (frameModel.singleModel.text) {
//        self.contentLabel.text = frameModel.singleModel.text;
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",frameModel.singleModel.text]];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing: 10];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [[NSString stringWithFormat:@"%@",frameModel.singleModel.text] length])];
        [self.contentLabel setAttributedText:attributedString1];
        [self.contentLabel sizeToFit];
        [self.contentView addSubview:self.contentLabel];
    } else {
        NSDictionary *dic = frameModel.singleModel.media;
        NSString *image = [dic objectForKey:@"absoluteMediaUrl"];
        [self.produceImageView sd_setImageWithURL:[NSURL URLWithString:image]];
    }
}

-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = LittleTextLabelFont;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}

-(UIImageView *)produceImageView
{
    if (!_produceImageView) {
        _produceImageView = [[UIImageView alloc] init];
        _produceImageView.layer.masksToBounds = YES;
        _produceImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _produceImageView;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
