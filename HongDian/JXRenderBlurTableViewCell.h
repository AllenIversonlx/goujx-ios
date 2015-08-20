//
//  JXRenderBlurTableViewCell.h
//  HongDian
//
//  Created by 姜通 on 15/8/10.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface JXRenderBlurTableViewCell : UITableViewCell

@property (nonatomic, retain) UIView *backView;
@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UIImageView *right_arrowImageView;
-(void)applyWithTitilString:(NSString *)string andIMageString:(NSString *)imagestring;

@end
