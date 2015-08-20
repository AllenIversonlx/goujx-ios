

//
//  AlertShow.m
//  HongDian
//
//  Created by 姜通 on 15/7/28.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "AlertShow.h"

@implementation AlertShow

+(void)passwordError{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名或密码错误，请重新登陆。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

+(void)registerError{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入完整信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

+(void)changePwdError{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请确定密码输入一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

+(void)phoneError{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

+(void)ImageError{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请上传头像" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
