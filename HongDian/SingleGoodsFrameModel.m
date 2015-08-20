//
//  SingleGoodsFrameModel.m
//  HongDian
//
//  Created by 姜通 on 15/8/11.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "SingleGoodsFrameModel.h"
#import "Config.h"
@implementation SingleGoodsFrameModel

-(void)setSingleModel:(SingleCaluteGoodsModel *)singleModel
{
    _singleModel = singleModel;
    CGRect frame = [UIScreen mainScreen].bounds;
    if ([[NSString stringWithFormat:@"%@",singleModel.mallProductDescribeTypeKey] isEqualToString:@"10"]) {
        self.cellHeight = [self reloadCalcuteTheHeightWithString:[NSString stringWithFormat:@"%@",singleModel.text] andFont:17] + 10;
        self.textFrame = CGRectMake(15, 10, frame.size.width - 30, self.cellHeight);
    } else if ([[NSString stringWithFormat:@"%@",singleModel.mallProductDescribeTypeKey] isEqualToString:@"20"]){
        NSDictionary *dic = singleModel.media;
        NSString *height = [dic objectForKey:@"height"];
        NSString *width = [dic objectForKey:@"width"];
 
        if (!height) {
            height = [NSString stringWithFormat:@"%f",frame.size.width];
        }
        
        if (!width) {
            width =  [NSString stringWithFormat:@"%f",frame.size.width];
        }
        CGFloat oldHeight = [height floatValue];
        CGFloat oldWidth = [width floatValue];
        
        CGFloat newWidth = frame.size.width * oldHeight / oldWidth ;
        self.cellHeight = newWidth;
        self.imageFrame = CGRectMake(0, 0, frame.size.width, self.cellHeight);
    }
}


-(CGFloat)reloadCalcuteTheHeightWithString:(NSString *)string andFont:(int)fontint{
    UIFont *font = [UIFont fontWithName:UserFont size:fontint];
    CGSize size = CGSizeMake(320, 300);
    NSDictionary *detaildic = @{NSFontAttributeName:font};
    CGSize newSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:detaildic context:nil].size;
    CGFloat height = 10 + newSize.height;
    return height;
}

@end
