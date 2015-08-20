//
//  BuyCarFrame.m
//  HongDian
//
//  Created by 姜通 on 15/7/21.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BuyCarFrame.h"

@implementation BuyCarFrame

-(void)setBuyCarModel:(BuyCarModel *)buyCarModel
{
    _buyCarModel = buyCarModel;
    CGRect frame = [UIScreen mainScreen].bounds;
    
    self.selectbuttonRect = CGRectMake(5, 5, 30, 30);
    self.delectbuttonRect = CGRectMake(frame.size.width - 35, 5, 30, 30);
    
//    self.headImageRect = CGRectMake(5, 5, 100, 100);
//    self.titleFloat = [self reloadCalcuteTheHeightWithString:[NSString stringWithFormat:@"%@",buyCarModel.titleString] andFont:12];
//    self.titleRect = CGRectMake(110, 10, frame.size.width - 110, self.titleFloat);
//    self.moneyFloat = [self reloadCalcuteTheHeightWithString:[NSString stringWithFormat:@"%@",buyCarModel.moneyString] andFont:14];
//    self.moneyRect = CGRectMake(110, self.titleFloat  + 15, frame.size.width - 105, self.moneyFloat);
//    self.sizeLabelFloat = [self reloadCalcuteTheHeightWithString:[NSString stringWithFormat:@"尺码:%@",buyCarModel.sizeSelectString] andFont:16];
//    CGSize SizeWidth = [self reloadCalcuteTheSizeWithString:[NSString stringWithFormat:@"尺码:%@",buyCarModel.sizeSelectString] andFont:16];
//    self.sizeLabelRect = CGRectMake(110, self.titleFloat + 20 + self.moneyFloat, SizeWidth.width, self.sizeLabelFloat);
//    
//    self.colorLabelFloat = [self reloadCalcuteTheHeightWithString:[NSString stringWithFormat:@"尺码:%@",buyCarModel.colorSelectString] andFont:16];
//    CGSize ColorWidth = [self reloadCalcuteTheSizeWithString:[NSString stringWithFormat:@"尺码:%@",buyCarModel.colorSelectString] andFont:16];
//    self.colorLabelRect = CGRectMake(110 + SizeWidth.width + 5, self.titleFloat + 20 + self.moneyFloat, ColorWidth.width, self.colorLabelFloat);
//    
    self.MessageRect = CGRectMake(0 , 40, frame.size.width, 5 + self.headImageheight + 5);
    
    self.numberLabelFloat = [self reloadCalcuteTheHeightWithString:@"购买数量" andFont:16];
    CGSize labelRect = [self reloadCalcuteTheSizeWithString:@"购买数量" andFont:16];
    self.numberLabelRect = CGRectMake(5, self.MessageRect.size.height + 40, labelRect.width, self.numberLabelFloat);
    
    self.addRect = CGRectMake(frame.size.width - 5,  self.MessageRect.size.height + 40, 20, 20);
    self.numberRect = CGRectMake(0, 0, 0, 0);
    self.miusRect = CGRectMake(0, 0, 0, 0);
}

-(CGFloat)reloadCalcuteTheHeightWithString:(NSString *)string andFont:(int)fontint{
    UIFont *font = [UIFont fontWithName:nil size:fontint];
    CGSize size = CGSizeMake(320, 300);
    NSDictionary *detaildic = @{NSFontAttributeName:font};
    CGSize newSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:detaildic context:nil].size;
    CGFloat height = 10 + newSize.height;
    return height;
}

-(CGSize)reloadCalcuteTheSizeWithString:(NSString *)string andFont:(int)fontint{
    UIFont *font = [UIFont fontWithName:nil size:fontint];
    CGSize size = CGSizeMake(320, 300);
    NSDictionary *detaildic = @{NSFontAttributeName:font};
    CGSize newSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:detaildic context:nil].size;
    return newSize;
}



@end
