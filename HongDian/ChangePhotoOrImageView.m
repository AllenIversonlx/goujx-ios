

//
//  ChangePhotoOrImageView.m
//  HongDian
//
//  Created by 姜通 on 15/8/20.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "ChangePhotoOrImageView.h"
#import "Config.h"
#import <Masonry/Masonry.h>

@implementation ChangePhotoOrImageView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UILabel *photolabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 60)];
        photolabel.text = @"拍照";
        photolabel.textAlignment = NSTextAlignmentCenter;
        photolabel.textColor = [UIColor whiteColor];
        photolabel.backgroundColor = ButtonColor;
        [self addSubview:photolabel];
        photolabel.userInteractionEnabled = YES;
        photolabel.layer.borderColor = CancleNomalColer.CGColor;
        photolabel.layer.borderWidth = 0.5;
        
        UILabel *Imagelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, Screen_Width(), 60)];
        Imagelabel.text = @"从手机相册选择";
        Imagelabel.textAlignment = NSTextAlignmentCenter;
        Imagelabel.textColor = [UIColor whiteColor];
        Imagelabel.backgroundColor = ButtonColor;
        [self addSubview:Imagelabel];
        Imagelabel.userInteractionEnabled = YES;
        
        UILabel *canclelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, Screen_Width(), 60)];
        canclelabel.text = @"取消";
        canclelabel.textAlignment = NSTextAlignmentCenter;
        canclelabel.textColor = [UIColor whiteColor];
        canclelabel.backgroundColor = CancleNomalColer;
        [self addSubview:canclelabel];
        canclelabel.userInteractionEnabled = YES;

        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectWhichTypeUseImage)];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectWhichTypeUsePhoto)];
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectWhichTypeUsecancle)];
        
        [photolabel addGestureRecognizer:tap];
        [Imagelabel addGestureRecognizer:tap2];
        [canclelabel addGestureRecognizer:tap3];
        
    }
    return self;
}

-(void)selectWhichTypeUseImage{
    if (self.selectWhichTypeUseImageBlock) {
        self.selectWhichTypeUseImageBlock();
    }
}


-(void)selectWhichTypeUsePhoto{
    if (self.selectWhichTypeUsePhotoBlock) {
        self.selectWhichTypeUsePhotoBlock();
    }
}

-(void)selectWhichTypeUsecancle{
    if (self.selectWhichTypeUsecancleBlock) {
        self.selectWhichTypeUsecancleBlock();
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
