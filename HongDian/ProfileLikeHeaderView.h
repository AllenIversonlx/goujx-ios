//
//  ProfileLikeHeaderView.h
//  HongDian
//
//  Created by 姜通 on 15/8/12.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BackToMianVcBlock)();
typedef void(^GotoSetVcBlock) ();
typedef void(^ChangeTheTypeBlock) (NSInteger tag,UIButton *btn);
typedef void(^SelectThePayOrderStatusBlock) (NSDictionary *dic);
typedef void(^SelectTheCouponStatusBlock) (NSDictionary *dic);


@interface ProfileLikeHeaderView : UIView

-(instancetype)initWithFrame:(CGRect)frame andtag:(NSString *)tag;

@property (nonatomic, retain) UIImageView *backImageView;
@property (nonatomic, retain) UIImageView *setImageView;
@property (nonatomic, retain) UIButton *orderButton;
@property (nonatomic, retain) UIButton *collectionbutton;
@property (nonatomic, retain) UIButton *daijinButton;

@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, copy) BackToMianVcBlock backToMainVcBlock;
@property (nonatomic, copy) GotoSetVcBlock gotobackVcBlock;
@property (nonatomic, copy) ChangeTheTypeBlock changethetypeBlock;
@property (nonatomic, copy) SelectThePayOrderStatusBlock selectThPayOrderBlock;
@property (nonatomic, copy) SelectTheCouponStatusBlock selectTheCouponBlock;

@end
