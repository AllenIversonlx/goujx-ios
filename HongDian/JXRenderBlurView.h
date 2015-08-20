//
//  JXRenderBlurView.h
//  HongDian
//
//  Created by 姜通 on 15/7/28.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXRenderBlurTableViewCell.h"

typedef void (^AnimationBlock)(NSString *tagString);
typedef void(^ClickThePersonVcBlock)(NSInteger tag);
typedef void(^ClickTheTableViewCelleBlock)(NSInteger cellTag);


@interface JXRenderBlurView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UIVisualEffectView *effectview;

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, copy) AnimationBlock toggleAction;
@property (nonatomic, copy) ClickThePersonVcBlock clickThePersonBlock;
@property (nonatomic, copy) ClickTheTableViewCelleBlock clickTableCellBlock;
@property (nonatomic, retain) NSArray *array;


@end
