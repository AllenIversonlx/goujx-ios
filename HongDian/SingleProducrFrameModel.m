


//
//  SingleProducrFrameModel.m
//  HongDian
//
//  Created by 姜通 on 15/7/29.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "SingleProducrFrameModel.h"

@implementation SingleProducrFrameModel

-(void)setSingleProductModel:(SingleProductModel *)singleProductModel
{
    _singleProductModel = singleProductModel;
    CGRect frame = [UIScreen mainScreen].bounds;
    self.headImageRect = CGRectMake(0, 0, frame.size.width,frame.size.width);
    
    self.titleFloat = [self reloadCalcuteTheHeightWithString:[NSString stringWithFormat:@"%@",singleProductModel.name] andFont:14];
    self.titleRect = CGRectMake(5, frame.size.width, frame.size.width - 5, self.titleFloat);
    
    self.dateFloat = [self reloadCalcuteTheHeightWithString:[NSString stringWithFormat:@"%@",singleProductModel.salePrice] andFont:12];
    self.dateRect = CGRectMake(5, self.titleFloat + frame.size.width , frame.size.width - 5, self.dateFloat);
    
    self.produceRect = CGRectMake(0, self.titleFloat + frame.size.width + self.dateFloat , frame.size.width, 40);
    self.allHeight =  self.titleFloat + frame.size.width + self.dateFloat + 40;
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


- (id)copyWithZone:(NSZone *)zone
{
    SingleProducrFrameModel *newModel = [[SingleProducrFrameModel alloc]init];
    
    /*n) CGFloat headImageheight;
     @property (nonatomic, assign) CGRect headImageRect;
     
     @property (nonatomic, assign) CGRect titleRect;
     @property (nonatomic, assign) CGFloat titleFloat;
     
     @property (nonatomic, assign) CGFloat dateFloat;
     @property (nonatomic, assign) CGRect dateRect;
     
     @property (nonatomic, assign) CGRect produceRect;
     @property (nonatomic, assign) CGFloat produceFloat;
     
     
     @property (nonatomic, assign) CGFloat allHeight;*/
    
    newModel.singleProductModel = self.singleProductModel;
    newModel.headImageheight = self.headImageheight;
    newModel.headImageRect = self.headImageRect;
    newModel.titleRect = self.titleRect;
    newModel.dateFloat = self.dateFloat;
    newModel.titleFloat = self.titleFloat;
    newModel.dateRect = self.dateRect;
    newModel.produceRect = self.produceRect;
    newModel.produceFloat = self.produceFloat;
    newModel.allHeight = self.allHeight;
    
    return newModel;
}


@end
