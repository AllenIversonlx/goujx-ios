



//
//  ShareView.m
//  HongDian
//
//  Created by 姜通 on 15/8/20.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "ShareView.h"
#import "Config.h"
#import <Masonry/Masonry.h>
@implementation ShareView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UILabel *photolabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 60)];
        photolabel.text = @"分享到微信好友";
        photolabel.textAlignment = NSTextAlignmentCenter;
        photolabel.textColor = [UIColor whiteColor];
        photolabel.backgroundColor = ButtonColor;
        [self addSubview:photolabel];
        photolabel.userInteractionEnabled = YES;
        photolabel.layer.borderColor = CancleNomalColer.CGColor;
        photolabel.layer.borderWidth = 0.5;
        
        UILabel *Imagelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, Screen_Width(), 60)];
        Imagelabel.text = @"分享到微信朋友圈";
        Imagelabel.textAlignment = NSTextAlignmentCenter;
        Imagelabel.textColor = [UIColor whiteColor];
        Imagelabel.backgroundColor = ButtonColor;
        [self addSubview:Imagelabel];
        Imagelabel.userInteractionEnabled = YES;
        Imagelabel.layer.borderColor = CancleNomalColer.CGColor;
        Imagelabel.layer.borderWidth = 0.5;
        
        UILabel *weibolabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, Screen_Width(), 60)];
        weibolabel.text = @"分享到新浪微博";
        weibolabel.textAlignment = NSTextAlignmentCenter;
        weibolabel.textColor = [UIColor whiteColor];
        weibolabel.backgroundColor = ButtonColor;
        [self addSubview:weibolabel];
        weibolabel.userInteractionEnabled = YES;
        
        UILabel *canclelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 180, Screen_Width(), 60)];
        canclelabel.text = @"取消";
        canclelabel.textAlignment = NSTextAlignmentCenter;
        canclelabel.textColor = [UIColor whiteColor];
        canclelabel.backgroundColor = CancleNomalColer;
        [self addSubview:canclelabel];
        canclelabel.userInteractionEnabled = YES;
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weixinfriend)];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weixingorup)];
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sinaShare)];
        UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancletheview)];

        [photolabel addGestureRecognizer:tap];
        [Imagelabel addGestureRecognizer:tap2];
        [weibolabel addGestureRecognizer:tap3];
        [canclelabel addGestureRecognizer:tap4];

    }
    return self;
}
-(void)weixinfriend{
    if (self.wechatFriendblock) {
        self.wechatFriendblock();
    }
}

-(void)weixingorup{
    if (self.wechatgroupblock) {
        self.wechatgroupblock();
    }
}

-(void)sinaShare{
    if (self.sinaShareBlock) {
        self.sinaShareBlock();
    }
}

-(void)cancletheview{
    if (self.cancleblock) {
        self.cancleblock();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
