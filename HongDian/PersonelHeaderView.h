//
//  PersonelHeaderView.h
//  HongDian
//
//  Created by 姜通 on 15/8/10.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BackToMainViewBlock)();
typedef void(^ChangeThePersonHeadImageBlock)(NSInteger tagselect);
//typedef void(^LoginGuideBlock)();


@interface PersonelHeaderView : UIView

@property (nonatomic, retain) UIImageView *deleteImageView;
@property (nonatomic, retain) UIImageView *headImageView;

@property (nonatomic, retain) UIImageView *messageImageView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UIImageView *moreImageView;

@property (nonatomic, copy) ChangeThePersonHeadImageBlock changeheaderBlock;
@property (nonatomic, copy) BackToMainViewBlock backtomainBlock;
//@property (nonatomic, copy) LoginGuideBlock loginBlock;
@end
