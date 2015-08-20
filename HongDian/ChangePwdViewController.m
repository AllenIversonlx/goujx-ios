

//
//  ChangePwdViewController.m
//  HongDian
//
//  Created by 姜通 on 15/7/22.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "ChangePwdViewController.h"
#import "Config.h"
#import <Masonry/Masonry.h>
#import "JXRequestManager.h"
#import "AlertShow.h"
#import "UIButton+Utilis.h"

@interface ChangePwdViewController ()

@end

@implementation ChangePwdViewController

-(void)loadTheUser:(UIButton *)btn {
    NSString *mobileAuthTokenString = [[NSUserDefaults standardUserDefaults] objectForKey:@"mobileAuthToken"];
    
    if (self.phoneTextField.text.length != 11 || self.messageTextField.text.length == 0 || self.pwdTextField.text.length == 0  ) {
        [AlertShow registerError];
        return;
    }
    if ([self.messageTextField.text isEqualToString:mobileAuthTokenString]) {
//        UserMessageViewController *usermes = [[UserMessageViewController alloc] init];
//        usermes.phoneNumber = self.phoneTextField.text;
//        usermes.pwdNumber = self.pwdTextField.text;
//        [self.navigationController pushViewController:usermes animated:YES];
    }
}

-(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

-(void)sengTheMessage:(UIButton *)btn {
    if (! [self isValidateMobile:self.phoneTextField.text]) {
        [AlertShow phoneError];
        return;
    }
    [[JXRequestManager sharedNetWorkManager] SendMobileAuthTokenWithMobileNumber:self.phoneTextField.text success:^(NSString *mobileAuthToken) {
        [[NSUserDefaults standardUserDefaults] setObject:mobileAuthToken forKey:@"mobileAuthToken"];
    } failture:^(NSString *errMsg) {
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"密码重置";
    
    [self.view addSubview:self.tableView];
    //    [self.view addSubview:self.registerButton];
    WS(weakSelf);
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset(25);
        make.right.equalTo(weakSelf.view.mas_right).offset(-25);
        make.height.equalTo(@60);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.bottom.equalTo(weakSelf.view.mas_bottom).equalTo(@-25);
    }];
}


#pragma mark - 选择头像
-(void)selectImageView{
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kTableViewCellStringForTFID = @"kTableViewCellStringForTFID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellStringForTFID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTableViewCellStringForTFID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    WS(weakSelf);
    switch (indexPath.row) {
        case 0:
        {
            [cell.contentView addSubview:self.phoneTextField];
            [cell.contentView addSubview:self.lineLabel];
            [cell.contentView addSubview:self.phoneImageView];
            
            [self.phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.mas_left).offset(70);
                make.centerY.equalTo(cell.mas_centerY);
                make.height.equalTo(@25);
                make.width.equalTo(@18);
            }];
            
            [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(weakSelf.phoneImageView.mas_right).offset(20);
                make.right.equalTo(cell.mas_right).offset(-35);
            }];
            
            [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.phoneImageView.mas_bottom).offset(20);
                make.left.equalTo(cell.mas_left).offset(35);
                make.right.equalTo(cell.mas_right).offset(-35);
                make.height.equalTo(@0.5);
            }];
            break;
        }
        case 1:
        {
            [cell.contentView addSubview:self.messageTextField];
            [cell.contentView addSubview:self.lineLabel2];
            [cell.contentView addSubview:self.messageButton];
            [cell.contentView addSubview:self.messagemageView];
            [self.messagemageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.mas_left).offset(70);
                make.centerY.equalTo(cell.mas_centerY);
                make.height.equalTo(@25);
                make.width.equalTo(@18);
            }];
            
            [self.messageTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(weakSelf.messagemageView.mas_right).offset(20);
                make.right.equalTo(cell.mas_right).offset(-35);
            }];
            
            [self.lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.messagemageView.mas_bottom).offset(20);
                make.left.equalTo(cell.mas_left).offset(35);
                make.right.equalTo(cell.mas_right).offset(-35);
                make.height.equalTo(@0.5);
            }];
            
            [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.right.equalTo(cell.mas_right).offset(-54);
            }];
            break;
        }

        case 2: {
            [cell.contentView addSubview:self.pwdImageView];
            [cell.contentView addSubview:self.lineLabel4];
            [cell.contentView addSubview:self.pwdTextField];
            [self.pwdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.mas_left).offset(70);
                make.top.equalTo(cell.mas_top).offset(17);
                make.height.equalTo(@25);
                make.width.equalTo(@18);
            }];
            
            [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(weakSelf.pwdImageView.mas_right).offset(20);
                make.right.equalTo(cell.mas_right).offset(-35);
            }];
            
            [self.lineLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.pwdImageView.mas_bottom).offset(20);
                make.left.equalTo(cell.mas_left).offset(35);
                make.right.equalTo(cell.mas_right).offset(-35);
                make.height.equalTo(@0.5);
            }];
            break;
        }
        case 3:{
            [cell.contentView addSubview:self.surePwdImageView];
            [cell.contentView addSubview:self.lineLabel5];
            [cell.contentView addSubview:self.surePwdTextField];
            [self.surePwdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.mas_left).offset(70);
                make.top.equalTo(cell.mas_top).offset(17);
                make.height.equalTo(@25);
                make.width.equalTo(@18);
            }];
            
            [self.surePwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(weakSelf.surePwdImageView.mas_right).offset(20);
                make.right.equalTo(cell.mas_right).offset(-35);
            }];
            
            [self.lineLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.surePwdImageView.mas_bottom).offset(20);
                make.left.equalTo(cell.mas_left).offset(35);
                make.right.equalTo(cell.mas_right).offset(-35);
                make.height.equalTo(@0.5);
            }];
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


-(void)submitChangePwd:(UIButton *)btn {
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


-(UITextField *)phoneTextField
{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.placeholder = @"请输入手机号";
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.delegate = self;
        _phoneTextField.font = TextLabelFont;
        _phoneTextField.tag = 1;
    }
    return  _phoneTextField;
}

-(UITextField *)pwdTextField
{
    if (!_pwdTextField) {
        _pwdTextField = [[UITextField alloc] init];
        _pwdTextField.placeholder = @"密码";
        _pwdTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _pwdTextField.secureTextEntry = YES;
        _pwdTextField.delegate = self;
        _pwdTextField.font = TextLabelFont;
        _pwdTextField.tag = 3;
    }
    return _pwdTextField;
    
}

-(UITextField *)messageTextField
{
    if (!_messageTextField) {
        _messageTextField = [[UITextField alloc] init];
        _messageTextField.placeholder = @"短信验证码";
        _messageTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _messageTextField.secureTextEntry = YES;
        _messageTextField.delegate = self;
        _messageTextField.tag = 2;
        _messageTextField.font = TextLabelFont;
    }
    return _messageTextField;
}

-(UITextField *)nickNameTextField
{
    if (!_nickNameTextField) {
        _nickNameTextField = [[UITextField alloc] init];
        _nickNameTextField.placeholder = @"昵称";
        _nickNameTextField.delegate = self;
        _nickNameTextField.font = TextLabelFont;
    }
    return _nickNameTextField;
}

-(UITextField *)surePwdTextField
{
    if (!_surePwdTextField) {
        _surePwdTextField = [[UITextField alloc] init];
        _surePwdTextField.placeholder = @"确认密码";
        _surePwdTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _surePwdTextField.secureTextEntry = YES;
        _surePwdTextField.delegate = self;
        _surePwdTextField.font = TextLabelFont;
    }
    return _surePwdTextField;
}

-(UIImageView *)phoneImageView
{
    if (!_phoneImageView) {
        _phoneImageView = [[UIImageView alloc] init];
        _phoneImageView.image = [UIImage imageNamed:@"phone"];
    }
    return _phoneImageView;
}

-(UIImageView *)messagemageView{
    if (!_messagemageView) {
        _messagemageView = [[UIImageView alloc] init];
        _messagemageView.image = [UIImage imageNamed:@"phoneMessage"];
    }
    return _messagemageView;
}

-(UIImageView *)surePwdImageView{
    if (!_surePwdImageView) {
        _surePwdImageView = [[UIImageView alloc] init];
        _surePwdImageView.image = [UIImage imageNamed:@"surePwd"];
    }
    return _surePwdImageView;
}

-(UIImageView *)nicknameImageView{
    if (!_nicknameImageView) {
        _nicknameImageView = [[UIImageView alloc] init];
        _nicknameImageView.image = [UIImage imageNamed:@"nickname"];
    }
    return _nicknameImageView;
}

-(UIImageView *)pwdImageView{
    if (!_pwdImageView) {
        _pwdImageView = [[UIImageView alloc] init];
        _pwdImageView.image = [UIImage imageNamed:@"pwd"];
    }
    return _pwdImageView;
}


#pragma mark - 协议
-(void)readTheDelegate{
    
}

#pragma mark - 验证码
-(void)sendTheMessage{
    
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

-(UILabel *)lineLabel3
{
    if (!_lineLabel3) {
        _lineLabel3 = [[UILabel alloc] init];
        _lineLabel3.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineLabel3;
}

-(UILabel *)lineLabel4
{
    if (!_lineLabel4) {
        _lineLabel4 = [[UILabel alloc] init];
        _lineLabel4.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineLabel4;
}

-(UILabel *)lineLabel5
{
    if (!_lineLabel5) {
        _lineLabel5 = [[UILabel alloc] init];
        _lineLabel5.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineLabel5;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), Screen_Height() - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.tableHeaderView = self.headView;
        _tableView.tableFooterView = self.footView;
    }
    return _tableView;
}


-(UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 134)];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = ButtonColor;
        imageView.layer.cornerRadius = 85 / 2;
        [_headView addSubview:imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImageView)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headView.mas_top).offset(35);
            make.width.equalTo(@85);
            make.height.equalTo(@85);
            make.centerX.equalTo(self.headView.mas_centerX);
        }];
    }
    return _headView;
}


-(UIView *)footView
{
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 125)];
        UIButton *button = [UIButton buttonWithTitleString:@"修改密码"];
        [button addTarget:self action:@selector(loadTheUser:) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:button];
        
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_footView.mas_top).offset(65);
            make.left.equalTo(@25);
            make.right.equalTo(@-25);
            make.height.equalTo(@60);
        }];
    }
    return _footView;
}


-(UIButton *)messageButton
{
    if (!_messageButton) {
        _messageButton = [[UIButton alloc] init];
        [_messageButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_messageButton setTitleColor:ButtonColor forState:UIControlStateNormal];
        [_messageButton addTarget:self action:@selector(sendTheMessage) forControlEvents:UIControlEventTouchUpInside];
        _messageButton.titleLabel.font =  TextLabelFont;
    }
    return _messageButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
