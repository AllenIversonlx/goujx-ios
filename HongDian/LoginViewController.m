


//
//  LoginViewController.m
//  HongDian
//
//  Created by 姜通 on 15/7/22.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "LoginViewController.h"
#import <Masonry/Masonry.h>
#import "Config.h"
#import "RegisterViewController.h"
#import "JXRequestManager.h"
#import "AlertShow.h"
#import "WXApi.h"
#import "UIButton+Utilis.h"
#import "Toast+UIView.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.delegate = self;
    self.navigationController.navigationBarHidden = NO;
}

//-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    if (viewController == self) {
//        self.navigationController.navigationBar.alpha = 0;
//    } else {
//        self.navigationController.navigationBar.alpha = 1;
//    }
//}


#pragma mark - 登录
-(void)submitChangePwd:(UIButton *)btn {
    NSString *regex = @"[0-9]{11}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self.nameTextField.text];
    if(! isMatch)
    {
        [[self view] makeToast:@"请输入正确手机号码" duration:1 position:@"bottom"];
        return;
    }
    [[JXRequestManager sharedNetWorkManager] requestLoadUserWithMobileNumber:self.nameTextField.text andpassword:self.pwdNewTextField.text success:^(NSString *token) {
        NSData *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:DeviceToken];
#pragma mark - 发送token
        [[JXRequestManager sharedNetWorkManager] RegisterIosDeviceToken:deviceToken success:^(NSString *token) {
        
             } failture:^(NSString *errMsg) {
        
             }];
        
        [[self view] makeToast:@"登录成功" duration:1 position:@"bottom"];
        NSString *accesstoken = [[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey];
        if (accesstoken) {
            [[JXRequestManager sharedNetWorkManager] GetPersonInformationsuccess:^(NSDictionary *dic) {
                NSString *imageString = [[dic objectForKey:@"avatar"] objectForKey:@"absoluteMediaUrl"];
                [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"omCrmCouponCount"] forKey:omCrmCouponCount];
                [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"omCrmUserLikeProduct"] forKey:omCrmUserLikeProduct];
                [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"omSaleOrderCount"] forKey:omSaleOrderCount];
                [[NSUserDefaults standardUserDefaults] setObject:imageString forKey:PersonInformation];
            } failture:^(NSString *errMsg) {
                
            }];
        }        
        [self.navigationController popViewControllerAnimated:YES];
    } failture:^(NSString *errMsg) {
        [[self view] makeToast:@"登录失败" duration:1 position:@"bottom"];
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"登录";
    [self.view addSubview: self.nameTextField];
    [self.view addSubview: self.pwdNewTextField];
    [self.view addSubview: self.nameImageView];
    [self.view addSubview: self.pwdImageView];
    [self.view addSubview: self.loginButton];
    [self.view addSubview: self.wechatLoginButton];
    [self.view addSubview: self.lineLabel];
    [self.view addSubview: self.lineLabel2];
    [self.view addSubview: self.forgetPwdButton];
    WS(weakSelf);
    [self.nameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(55);
        make.left.equalTo(weakSelf.view.mas_left).offset(70);
        make.height.equalTo(@25);
        make.width.equalTo(@18);
    }];
    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(60);
        make.left.equalTo(weakSelf.nameImageView.mas_right).offset(20);
        make.right.equalTo(weakSelf.view.mas_right).offset(-35);
    }];
    
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameImageView.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.view.mas_left).offset(35);
        make.right.equalTo(weakSelf.view.mas_right).offset(-35);
        make.height.equalTo(@0.5);
    }];
    
    
    [self.pwdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lineLabel.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.view.mas_left).offset(70);
        make.height.equalTo(@25);
        make.width.equalTo(@18);
    }];
    
    [self.pwdNewTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lineLabel.mas_bottom).offset(25);
        make.left.equalTo(weakSelf.pwdImageView.mas_right).offset(20);
        make.right.equalTo(weakSelf.view.mas_right).offset(-35);
    }];
    
    [self.lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.pwdImageView.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.view.mas_left).offset(35);
        make.right.equalTo(weakSelf.view.mas_right).offset(-35);
        make.height.equalTo(@0.5);
    }];
    
    [self.forgetPwdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).offset(-35);
        make.top.equalTo(weakSelf.lineLabel2.mas_bottom).offset(10);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(25);
        make.right.equalTo(weakSelf.view.mas_right).offset(-25);
        make.height.equalTo(@60);
        make.top.equalTo(weakSelf.lineLabel2.mas_top).offset(65);
    }];
    
//    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.view.mas_left).offset(25);
//        make.right.equalTo(weakSelf.view.mas_right).offset(-25);
//        make.height.equalTo(@60);
//        make.centerX.equalTo(weakSelf.view.mas_centerX);
//        make.bottom.equalTo(weakSelf.view.mas_bottom).equalTo(@-25);
//    }];
}


#pragma mark - 微信登陆
-(void)wechatLoginWithUser:(UIButton *)btn{
    SendAuthReq *req= [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo";
    [WXApi sendReq:req];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark - 忘记密码
-(void)forgetThePwd{
    RegisterViewController *registerUer = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerUer animated:YES];
}


-(UIButton *)forgetPwdButton
{
    if (!_forgetPwdButton) {
        _forgetPwdButton = [[UIButton alloc] init];
        [_forgetPwdButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetPwdButton setTitleColor:ButtonColor forState:UIControlStateNormal];
        [_forgetPwdButton addTarget:self action:@selector(forgetThePwd) forControlEvents:UIControlEventTouchUpInside];
        _forgetPwdButton.titleLabel.font =  [UIFont fontWithName:UserFont size:13];
    }
    return _forgetPwdButton;
}

-(UITextField *)nameTextField
{
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.placeholder = @"移动电话";
        _nameTextField.keyboardType = UIKeyboardTypeNumberPad;
        _nameTextField.delegate = self;
        _nameTextField.font = TextLabelFont;
        _nameTextField.tag = 1;
    }
    return  _nameTextField;
}

-(UITextField *)pwdNewTextField
{
    if (!_pwdNewTextField) {
        _pwdNewTextField = [[UITextField alloc] init];
        _pwdNewTextField.placeholder = @"密码";
        _pwdNewTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _pwdNewTextField.secureTextEntry = YES;
        _pwdNewTextField.delegate = self;
        _pwdNewTextField.font = TextLabelFont;
        _pwdNewTextField.tag = 2;
    }
    return _pwdNewTextField;
}

-(UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithTitleString:@"登录"];
        [_loginButton addTarget:self action:@selector(submitChangePwd:) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.tag = 1;
    }
    return _loginButton;
}

-(UIButton *)wechatLoginButton
{
    if (!_wechatLoginButton) {
        _wechatLoginButton = [UIButton buttonWithTitleString:@"微信登陆"];
        [_wechatLoginButton addTarget:self action:@selector(wechatLoginWithUser:) forControlEvents:UIControlEventTouchUpInside];
        _wechatLoginButton.tag = 3;
    }
    return _wechatLoginButton;
}

-(UILabel *)lineLabel
{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineLabel;
}

-(UILabel *)lineLabel2
{
    if (!_lineLabel2) {
        _lineLabel2 = [[UILabel alloc] init];
        _lineLabel2.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineLabel2;
}


-(UIButton *)registerButton
{
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithTitleString:@"注册"];
        [_registerButton addTarget:self action:@selector(registerTheUser:) forControlEvents:UIControlEventTouchUpInside];
        _registerButton.tag = 2;
    }
    return _registerButton;
}

-(UIImageView *)nameImageView
{
    if (!_nameImageView) {
        _nameImageView = [[UIImageView alloc] init];
        _nameImageView.image = [UIImage imageNamed:@"phone"];
    }
    return _nameImageView;
}

-(UIImageView *)pwdImageView
{
    if (!_pwdImageView) {
        _pwdImageView = [[UIImageView alloc] init];
        _pwdImageView.image = [UIImage imageNamed:@"pwd"];
    }
    return _pwdImageView;
}

-(void)registerTheUser:(UIButton *)btn {
    RegisterViewController *registerUer = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerUer animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
