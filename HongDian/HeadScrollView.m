




//
//  HeadScrollView.m
//  HongDian
//
//  Created by 姜通 on 15/8/18.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "HeadScrollView.h"
#import "ImageButton.h"
#import "Config.h"

//使用block回调产生 延迟成本，此处换成delegate //可忽略。。
@protocol DRTabBarItemDelegate <NSObject>

- (void)clickAction:(UITapGestureRecognizer *)tapGesture;

@end
typedef void (^TabButtonAction) (NSInteger tag);

/**
 *  自定义TabBarButton类型
 */
@interface DRTabBarItem : UIView

@property (nonatomic, copy) TabButtonAction buttonAction;

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIButton *buttonItem;//__unused
@property (nonatomic, strong) ImageButton *button;

@property (nonatomic, weak) id<DRTabBarItemDelegate>tapDelegate;

- (void)setSelected:(BOOL)selected;

- (void)setButtonTitle:(NSString *)title
        withTitleColor:(UIColor *)color
              andImage:(UIImage *)image;

@end


#pragma mark - custom Tabbar item
@implementation DRTabBarItem

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundView = [[UIView alloc]initWithFrame:self.bounds];
        
        self.button = [[ImageButton alloc]initWithFrame:self.bounds];
        [self.button addTarget:self andAction:@selector(clickAction:)];
        
        [self.backgroundView addSubview:self.button];
        
        [self addSubview:self.backgroundView];
    }
    
    return self;
}

- (void)setButtonTitle:(NSString *)title
        withTitleColor:(UIColor *)color
{
    [self.button setTitle:title withFontSize:13 andColor:color];
}

- (void)clickAction:(id)btn
{
    if (self.buttonAction) {
        if ([btn isKindOfClass:[UITapGestureRecognizer class]]){
            UITapGestureRecognizer *tapBtn = ((UITapGestureRecognizer *)btn);
            if (tapBtn.state == UIGestureRecognizerStateEnded) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.buttonAction(tapBtn.view.superview.superview.tag);
                });
            }
        }
    }
}


- (void)setSelected:(BOOL)selected
{
    if (selected) {
        self.backgroundView.backgroundColor = [UIColor whiteColor];
    } else {
        self.backgroundView.backgroundColor = [UIColor whiteColor];
    }
}

@end




@implementation HeadScrollView



-(instancetype)initWithFrame:(CGRect)frame WithArray:(NSArray *)array
{
    if (self = [super initWithFrame:frame]) {
        self.dataArray = array;
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 44)];
        self.scrollView.bounces = YES;
        self.scrollView.userInteractionEnabled = YES;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.scrollView];
 
        
        NSMutableArray *btnArr = [NSMutableArray array];
        CGFloat itemWidth = Screen_Width() / 4;
        for (int i = 0; i < self.dataArray.count; i++) {
            DRTabBarItem *shopBtn = [[DRTabBarItem alloc] initWithFrame:CGRectMake(i*itemWidth, 0, itemWidth, 44)];
            [shopBtn setButtonTitle:[self.dataArray[i] objectForKey:@"name"] withTitleColor:CancleNomalColer];
            shopBtn.tag = i+100;
            __weak typeof(self)weakSelf = self;
            shopBtn.buttonAction = ^(NSInteger tag){
                [weakSelf selectTab:tag-100];
            };
            
            [self.scrollView addSubview:shopBtn];
            [btnArr addObject:shopBtn];
            self.scrollView.contentSize =CGSizeMake(itemWidth * self.dataArray.count,44);

        }
        [self selectTab:0];
    }
    return self;
}


- (void)selectTab:(NSInteger)tag
{
    for (UIView *abtn in self.scrollView.subviews) {
        if ([abtn isKindOfClass:[DRTabBarItem class]]) {
            DRTabBarItem *bb = (DRTabBarItem *)abtn;
            if (bb.tag - 100 == tag) {
//                NSArray *titleArr = @[@"附近",@"消息",@"留言板",@"我"];
                [bb setButtonTitle:[self.dataArray[bb.tag - 100] objectForKey:@"name"] withTitleColor:ButtonColor];
                if (self.tapScrollButtonBlock) {
                    self.tapScrollButtonBlock(self.dataArray[bb.tag - 100]);
                }
                
                [bb setSelected:YES];
            } else {
//                NSArray *titleArr = @[@"附近",@"消息",@"留言板",@"我"];
                [bb setButtonTitle:[self.dataArray[bb.tag - 100] objectForKey:@"name"] withTitleColor:CancleNomalColer];
                [bb setSelected:NO];
            }
        }
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
