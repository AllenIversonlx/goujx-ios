

//
//  ChangeNickNameViewController.m
//  HongDian
//
//  Created by 姜通 on 15/8/17.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "ChangeNickNameViewController.h"
#import "Config.h"
#import "JXRequestManager.h"
#import "Toast+UIView.h"
@interface ChangeNickNameViewController ()

@end

@implementation ChangeNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"修改昵称";
    [self.view addSubview:self.textField];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(AddName) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn sizeToFit];
    rightBtn.titleLabel.font = TextLabelFont;
    [rightBtn setTitleColor:ButtonColor forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)AddName{
    [[JXRequestManager sharedNetWorkManager] actionUpdateCrmUserNickName:self.textField.text success:^(NSDictionary *dic) {
        if (![dic objectForKey:@"code"]) {
            NSString *imageString = [[dic objectForKey:@"avatar"] objectForKey:@"absoluteMediaUrl"];
            [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"omCrmCouponCount"] forKey:omCrmCouponCount];
            [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"omCrmUserLikeProduct"] forKey:omCrmUserLikeProduct];
            [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"omSaleOrderCount"] forKey:omSaleOrderCount];
            [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"name"] forKey:PersonName];
            [[NSUserDefaults standardUserDefaults] setObject:imageString forKey:PersonInformation];
        } else {
            [[self view] makeToast:@"更新信息失败" duration:1 position:@"bottom"];
        }
    } failture:^(NSString *errMsg) {
        [[self view] makeToast:@"更新信息失败" duration:1 position:@"bottom"];
    }];
}

-(UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 100, Screen_Width() - 60, 60)];
        _textField.borderStyle = UITextBorderStyleBezel;
        _textField.delegate = self;
        _textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:PersonName];
        _textField.font = TextLabelFont;
    }
    return _textField;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
