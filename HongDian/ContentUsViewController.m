

//
//  ContentUsViewController.m
//  HongDian
//
//  Created by 姜通 on 15/8/20.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "ContentUsViewController.h"
#import "Config.h"
@interface ContentUsViewController ()

@end

@implementation ContentUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackGroundColor;
    self.titleLabel.text = @"联系我们";
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), Screen_Height() - 64)];
    webView.backgroundColor = [UIColor clearColor];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ContentUsUrl]]];
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
