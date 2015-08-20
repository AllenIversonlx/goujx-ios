//
//  TitleCollectionViewCell.h
//  HongDian
//
//  Created by 姜通 on 15/8/18.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleModel.h"
typedef void(^TapTheBlock)(UIButton *btn,TitleModel *model);



@interface TitleCollectionViewCell : UICollectionViewCell
@property (nonatomic, retain) TitleModel *model;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIButton *button;

-(TitleModel *)getModel;

@property (nonatomic, copy) TapTheBlock tapBlock;
@end
