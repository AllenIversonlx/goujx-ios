


//
//  TermsViewController.m
//  HongDian
//
//  Created by 姜通 on 15/8/19.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "TermsViewController.h"
#import "Config.h"

@interface TermsViewController ()

@end

@implementation TermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackGroundColor;
    self.titleLabel.text = @"锦向用户协议";
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), Screen_Height() - 64)];
    webView.backgroundColor = [UIColor clearColor];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:UserTermsUrl]]];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
