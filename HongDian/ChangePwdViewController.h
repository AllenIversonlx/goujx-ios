//
//  ChangePwdViewController.h
//  HongDian
//
//  Created by 姜通 on 15/7/22.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BaseViewController.h"

@interface ChangePwdViewController : BaseViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITextField *phoneTextField;
@property (nonatomic, retain) UITextField *messageTextField;
@property (nonatomic, retain) UITextField *pwdTextField;
@property (nonatomic, retain) UITextField *nickNameTextField;
@property (nonatomic, retain) UITextField *surePwdTextField;
@property (nonatomic, retain) UIImageView *phoneImageView;
@property (nonatomic, retain) UIImageView *messagemageView;
@property (nonatomic, retain) UIImageView *nicknameImageView;
@property (nonatomic, retain) UIImageView *pwdImageView;
@property (nonatomic, retain) UIImageView *surePwdImageView;

@property (nonatomic, retain) UILabel *lineLabel;
@property (nonatomic, retain) UILabel *lineLabel3;
@property (nonatomic, retain) UILabel *lineLabel2;
@property (nonatomic, retain) UILabel *lineLabel4;
@property (nonatomic, retain) UILabel *lineLabel5;

@property (nonatomic, retain) UIButton *registerButton;
@property (nonatomic, retain) UIButton *messageButton;
@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) UIView *headView;
@property (nonatomic, retain) UIView *footView;
@end
