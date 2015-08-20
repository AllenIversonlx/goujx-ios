

//
//  GuidanceLoginViewController.m
//  HongDian
//
//  Created by 姜通 on 15/8/10.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "GuidanceLoginViewController.h"
#import "Config.h"
#import <Masonry/Masonry.h>
#import "UIButton+Utilis.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "WXApi.h"
#import <WeiboSDK/WeiboSDK.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface GuidanceLoginViewController ()

@property (nonatomic, retain) MPMoviePlayerController *moviePlayer;
@end

@implementation GuidanceLoginViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    self.navigationController.navigationBarHidden = YES;
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackGroundColor;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"launch" ofType:@"m4v"];
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePath];
    
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];

    playerLayer.frame = CGRectMake(-Screen_Height()/2 + 186, 0, Screen_Height(), Screen_Height());

    [self.view.layer addSublayer:playerLayer];
    [player play];
    
    player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[player currentItem]];
    
    
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.image = [UIImage imageNamed:@"logo-白底"];
    [self.view addSubview:logoImageView];
    
    UIImageView *deleteImageView = [[UIImageView alloc] init];
    [self.view addSubview:deleteImageView];
    deleteImageView.image = [UIImage imageNamed:@"delete"];
    deleteImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToMainVC)];
    [deleteImageView addGestureRecognizer:tap];
    
    WS(weakSelf);
    [deleteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(35);
        make.right.equalTo(weakSelf.view.mas_right).offset(-15);
        make.width.equalTo(@17);
        make.height.equalTo(@17);
    }];

    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(120);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.width.equalTo(@200);
        make.height.equalTo(@200);
    }];
    
    
    UIButton *registerButton = [[UIButton alloc] init];
    [registerButton setTitle:@"没有帐号？30秒创建帐号" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    registerButton.titleLabel.font = TextLabelFont;
    
    UIButton *loginButton = [UIButton borderbuttonWithTitleString:@"锦向账号登陆" andWithColor: LoginInColor];
    [loginButton addTarget:self action:@selector(LoginIn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-80);
        make.height.equalTo(@60);
        make.left.equalTo(@25);
        make.right.equalTo(@-25);
    }];
    
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.bottom.equalTo(loginButton.mas_top).offset(-15);
    }];
 
    UIImageView *wechatimageView = [[UIImageView alloc] init];
    wechatimageView.image = [UIImage imageNamed:@"微信登录"];
    [self.view addSubview:wechatimageView];
    [wechatimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_centerX).offset(-10);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-25);
    }];
    wechatimageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *wechatLogin = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wechatLogin)];
    [wechatimageView addGestureRecognizer:wechatLogin];
    
    
    UIImageView *sinaimageView = [[UIImageView alloc] init];
    sinaimageView.image = [UIImage imageNamed:@"微博登录"];
    [self.view addSubview:sinaimageView];
    [sinaimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_centerX).offset(10);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-25);
    }];
//    sinaimageView.backgroundColor = [UIColor redColor];
    sinaimageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *sinaLogin = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weiBoLoging)];
    [sinaimageView addGestureRecognizer:sinaLogin];
}

-(void)wechatLogin{
    SendAuthReq *req= [[SendAuthReq alloc] init];
    req.scope =  @"snsapi_userinfo";
    [WXApi sendReq:req];
}

-(void)weiBoLoging{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = @"http://goujx.com";
    request.scope = @"all";
//    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
//                         @"Other_Info_1": [NSNumber numberWithInt:123],
//                         @"Other_Info_2": @[@"obj1", @"obj2"],
//                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

-(void)registerView{
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(void)LoginIn:(UIButton *)btn{
    LoginViewController *login = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
}

-(void)backToMainVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}


//重写此方法 为了 让右上角的 选择按钮 更加 好 点击
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGRect rect = CGRectMake(self.view.frame.size.width - 60, 35, 40, 40);
    CGPoint point = [[touches anyObject] locationInView:self.view];
    if (CGRectContainsPoint(rect, point)) {
        [self backToMainVC];
        return;
    }
    //如果不调用super方法，tableView的代理方法不会响应
    [super touchesBegan:touches withEvent:event];
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
