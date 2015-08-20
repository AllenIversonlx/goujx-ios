

//
//  FeedbackViewController.m
//  HongDian
//
//  Created by 姜通 on 15/7/21.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "FeedbackViewController.h"
#import <Masonry/Masonry.h>

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"意见反馈";
    
    WS(weakSelf);
    UILabel *label = [[UILabel alloc] init];
    label.text = @"留下您的宝贵意见吧";
    [self.view addSubview:label];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.layer.borderWidth = 1;
    textView.scrollEnabled = YES;
    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:textView];
    
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(feedBack:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"加入购物车" forState:UIControlStateNormal];
    button.layer.borderColor = [UIColor colorWithRed:90/255.0 green:198/255.0 blue:184/255.0 alpha:1.0].CGColor;
    button.layer.borderWidth = 1;
    [button setTitleColor:[UIColor colorWithRed:90/255.0 green:198/255.0 blue:184/255.0 alpha:1.0] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    button.contentEdgeInsets = UIEdgeInsetsMake(5,10, 5, 10);
    [self.view addSubview:button];
    
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.top.equalTo(@80);
    }];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(20);
        make.left.equalTo(@40);
        make.right.equalTo(@-40);
        make.bottom.equalTo(@-200);
    }];
    
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textView.mas_bottom).offset(40);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.width.equalTo(@160);
        make.height.equalTo(@40);
    }];
    // Do any additional setup after loading the view.
}

-(void)feedBack:(UIButton *)btn{
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
