

//
//  RegisterViewController.m
//  HongDian
//
//  Created by 姜通 on 15/7/22.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "RegisterViewController.h"
#import "Config.h"
#import <Masonry/Masonry.h>
#import "JXRequestManager.h"
#import "AlertShow.h"
#import "UIButton+Utilis.h"
#import "Toast+UIView.h"
#import "TermsViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController


#pragma mark - 验证码
-(void)sendTheMessage:(UIButton *)sender{
    if (sender.enabled) {
        NSString *regex = @"[0-9]{11}";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:self.phoneTextField.text];
        if(! isMatch)
        {
            [[self view] makeToast:@"请输入正确手机号码" duration:1 position:@"bottom"];
            return;
        }
        sender.enabled=NO;
        sender.backgroundColor=[UIColor lightGrayColor];
        //网络请求
        [self SendAccesMessage];
        
        _second = 59;
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAuction:) userInfo:nil repeats:YES];
    }
}

-(void)SendAccesMessage{
    [[JXRequestManager sharedNetWorkManager] SendMobileAuthTokenWithMobileNumber:self.phoneTextField.text success:^(NSString *token) {
        [[self view] makeToast:@"发送验证码成功" duration:1 position:@"bottom"];
    } failture:^(NSString *errMsg) {
        [[self view] makeToast:errMsg duration:1 position:@"bottom"];
    }];
}

-(void)countDownAuction:(NSTimer*)timer
{
    [_messageButton setTitle:[NSString stringWithFormat:@"重发(%d)",_second--] forState:UIControlStateDisabled];
    if (_second==-1) {
        _messageButton.enabled=YES;
        _messageButton.backgroundColor=[UIColor blackColor];
        [_messageButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _second = 59;
        [timer invalidate];
    }
}


-(void)loadTheUser:(UIButton *)btn {
    __weak __typeof(self) weskSelf = self;
//    NSString *mobileAuthToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"mobileAuthToken"];
//    if (![self.messageTextField.text isEqualToString:mobileAuthToken]) {
//        [[self view] makeToast:@"请输入正确的验证码" duration:1 position:@"bottom"];
//    }
    NSString *regex = @"[0-9]{11}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self.phoneTextField.text];
    if(! isMatch)
    {
        [[self view] makeToast:@"请输入正确手机号码" duration:1 position:@"bottom"];
        return;
    }
    if (self.headImageView.image == nil) {
        [[self view] makeToast:@"请上传您的头像" duration:1 position:@"bottom"];
        return;
    }
    if (! [self.pwdTextField.text isEqualToString:self.surePwdTextField.text]) {
        [[self view] makeToast:@"请确认密码是否一致" duration:1 position:@"bottom"];
    }
    
    [[JXRequestManager sharedNetWorkManager] RegisterWithMobileNumber:weskSelf.phoneTextField.text pwd:weskSelf.pwdTextField.text name:self.nickNameTextField.text photoImahe:self.headImageView.image andAccessToken:self.messageTextField.text success:^(NSString *token) {
        NSData *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:DeviceToken];
#pragma mark - 发送token
        [[JXRequestManager sharedNetWorkManager] RegisterIosDeviceToken:deviceToken success:^(NSString *token) {
            
        } failture:^(NSString *errMsg) {
            
        }];
        
        [[self view] makeToast:@"注册成功" duration:1 position:@"bottom"];
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
    } failture:^(NSString *errMsg) {
        [[self view] makeToast:@"注册失败" duration:1 position:@"bottom"];
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.phoneTextField resignFirstResponder];
    [self.pwdImageView resignFirstResponder];
    [self.surePwdTextField resignFirstResponder];
    [self.messageTextField resignFirstResponder];
    [self.nickNameTextField resignFirstResponder];
    
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [self.tableView endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"注册";
    
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


-(void)SelectImageWithPhoto:(UITapGestureRecognizer *)tap{
    UIActionSheet *myActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", @"拍照", nil];
    [myActionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            //从相册选择
            [self LocalPhoto];
            break;
            
        case 1:
            //拍照
            [self takePhoto];
            break;
            
        default:
            break;
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    viewController.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    viewController.navigationController.navigationBar.barTintColor = ButtonColor;
}


#pragma mark - 从相册选取
-(void)LocalPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择图片后可以编辑
    picker.allowsEditing = YES;
    picker.navigationBar.backgroundColor = [UIColor blackColor];

    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - 照相
-(void)takePhoto{
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        picker.navigationBar.backgroundColor = [UIColor blackColor];

        [self presentViewController:picker animated:YES completion:nil];
    } else {
        NSLog(@"该设备无摄像头");
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *headPhotoImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        self.headImageView.image = headPhotoImage;
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
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
            self.phoneTextField.delegate = self;

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
            self.messageTextField.delegate = self;

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
        case 2:
        {
            [cell.contentView addSubview:self.nicknameImageView];
            [cell.contentView addSubview:self.lineLabel3];
            self.nickNameTextField.delegate = self;

            [cell.contentView addSubview:self.nickNameTextField];
            [self.nicknameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.mas_left).offset(70);
                make.top.equalTo(cell.mas_top).offset(17);

                make.height.equalTo(@25);
                make.width.equalTo(@18);
            }];
            
            [self.nickNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(weakSelf.nicknameImageView.mas_right).offset(20);
                make.right.equalTo(cell.mas_right).offset(-35);
            }];
            
            [self.lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.nicknameImageView.mas_bottom).offset(20);
                make.left.equalTo(cell.mas_left).offset(35);
                make.right.equalTo(cell.mas_right).offset(-35);
                make.height.equalTo(@0.5);
            }];
            break;
        }
        case 3: {
            [cell.contentView addSubview:self.pwdImageView];
            [cell.contentView addSubview:self.lineLabel4];
            self.pwdTextField.delegate = self;
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
        case 4:{
            [cell.contentView addSubview:self.surePwdImageView];
            [cell.contentView addSubview:self.lineLabel5];
            [cell.contentView addSubview:self.surePwdTextField];
            self.surePwdTextField.delegate = self;
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


-(UITextField *)phoneTextField
{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.placeholder = @"请输入手机号";
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
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
    TermsViewController *termsVC = [[TermsViewController alloc] init];
    [self.navigationController pushViewController:termsVC animated:YES];
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
        _tableView.tableHeaderView = self.headView;
        _tableView.tableFooterView = self.footView;
    }
    return _tableView;
}


-(UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 134)];
        self.headImageView = [[UIImageView alloc] init];
        self.headImageView.backgroundColor = ButtonColor;
        self.headImageView.layer.cornerRadius = 85 / 2;
        self.headImageView.layer.masksToBounds = YES;
        [_headView addSubview:self.headImageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SelectImageWithPhoto:)];
        self.headImageView.userInteractionEnabled = YES;
        [self.headImageView addGestureRecognizer:tap];
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
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
        UIButton *button = [UIButton buttonWithTitleString:@"同意协议并注册"];
        [button addTarget:self action:@selector(loadTheUser:) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:button];
        
        
        UIButton *delegteButton = [[UIButton alloc] init];
        [delegteButton setTitle:@"《锦向服务协议》" forState:UIControlStateNormal];
        [delegteButton setTitleColor:ButtonColor forState:UIControlStateNormal];
        [delegteButton addTarget:self action:@selector(readTheDelegate) forControlEvents:UIControlEventTouchUpInside];
        delegteButton.titleLabel.font =  [UIFont fontWithName:UserFont size:13];
        [_footView addSubview:delegteButton];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_footView.mas_top).offset(65);
            make.left.equalTo(@25);
            make.right.equalTo(@-25);
            make.height.equalTo(@60);
        }];
        
        [delegteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_footView.mas_top).offset(15);
            make.right.equalTo(_footView.mas_right).offset(-45);
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
        [_messageButton addTarget:self action:@selector(sendTheMessage:) forControlEvents:UIControlEventTouchUpInside];
        _messageButton.enabled = YES;
        _messageButton.titleLabel.font =  [UIFont fontWithName:UserFont size:17];
    }
    return _messageButton;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.pwdTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.surePwdTextField resignFirstResponder];
    [self.messageTextField resignFirstResponder];
    [self.nickNameTextField resignFirstResponder];
    [UIView animateWithDuration:1 animations:^{
        self.tableView.frame = CGRectMake(0, 0, Screen_Width(), Screen_Height() - 64);
    } completion:^(BOOL finished) {
        
    }];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.pwdTextField || textField == self.surePwdTextField) {
        [UIView animateWithDuration:1 animations:^{
            self.tableView.frame = CGRectMake(0, -200, Screen_Width(), Screen_Height() - 64);
        } completion:^(BOOL finished) {
            
        }];
    }
    return YES;
}

//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    if (textField == self.pwdTextField) {
//        [UIView animateWithDuration:1 animations:^{
//            self.tableView.frame = CGRectMake(0, 0, Screen_Width(), Screen_Height() - 64);
//        } completion:^(BOOL finished) {
//            
//        }];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
