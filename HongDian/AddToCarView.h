//
//  AddToCarView.h
//  HongDian
//
//  Created by 姜通 on 15/7/21.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleProducrFrameModel.h"
typedef void(^CancleThePushViewBlock) ();

@interface AddToCarView : UIView

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *moneyLabel;

@property (nonatomic, copy) CancleThePushViewBlock canclePushViewBlock;
@property (nonatomic, retain) SingleProducrFrameModel *frameModel;

@end
