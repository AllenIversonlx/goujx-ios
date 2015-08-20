//
//  LoginViewController.h
//  HongDian
//
//  Created by 姜通 on 15/7/22.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController<UITextFieldDelegate,UINavigationControllerDelegate>


@property (nonatomic, retain) UITextField *nameTextField;
@property (nonatomic, retain) UITextField *pwdNewTextField;
@property (nonatomic, retain) UIImageView *nameImageView;
@property (nonatomic, retain) UIImageView *pwdImageView;
@property (nonatomic, retain) UILabel *lineLabel;
@property (nonatomic, retain) UILabel *lineLabel2;

@property (nonatomic, retain) UIButton *forgetPwdButton;

@property (nonatomic, retain) UIButton *loginButton;
@property (nonatomic, retain) UIButton *wechatLoginButton;

@property (nonatomic, retain) UIButton *registerButton;
@end
