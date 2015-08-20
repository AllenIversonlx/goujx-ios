//
//  SingleGoodsViewController.m
//  HongDian
//
//  Created by 姜通 on 15/7/20.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "SingleGoodsViewController.h"
#import "Toast+UIView.h"
#import "ShareView.h"
@interface SingleGoodsViewController ()
@property (nonatomic, retain) SingleBottomView *singleBottomView;
@property (nonatomic, retain) ShareView *shareView;
@end

@implementation SingleGoodsViewController

//-(SingleBottomView *)singleBottomView
//{
//    if (!_singleBottomView) {
//        _singleBottomView = [[SingleBottomView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 128, self.view.frame.size.width, 64)];
//        _singleBottomView.layer.borderWidth = 2;
//        _singleBottomView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    }
//    return _singleBottomView;
//}
//
//弹出选择view
#pragma mark - 弹出选择view
-(void)PushSeletGoosTypeView{
//    [self presentSemiView:self.selectTypeView];
//    [self.view addSubview:self.singleBottomView];
    WS(weakSelf);
//    self.singleBottomView.tapButtonBlock = ^(NSInteger tag){
//        [weakSelf presentSemiView:weakSelf.selectTypeView];
//        weakSelf.selectTag = tag;
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.selectTypeView.frame = CGRectMake(0, weakSelf.view.frame.size.height * 0.3 , weakSelf.view.frame.size.width, Screen_Height() *0.7);
                CALayer *layer = weakSelf.beforeView.layer;
                layer.zPosition = -4000;
//                CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
//                rotationAndPerspectiveTransform.m34 = 1.0 / -300;
//                layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform, 10.0f * M_PI / 180.0f, 1.0f, 0.0f, 0.0f);
                weakSelf.beforeView.backgroundColor = [UIColor blackColor];
                weakSelf.beforeView.alpha = 0.8;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
//                weakSelf.beforeView.transform = CGAffineTransformMakeScale(0.9, 0.9);
                weakSelf.beforeView.backgroundColor = [UIColor blackColor];
                weakSelf.beforeView.alpha = 0.8;
            }];
        }];
//    };
}

#pragma mark - 隐藏选择的view
-(void)showTheGoodsView{
//    [self presentSemiView:self.selectTypeView];
    self.beforeView.userInteractionEnabled=YES;
//    self.goodView.userInteractionEnabled = YES;
    [UIView animateWithDuration:0.3 animations:^{
        CALayer *layer = self.beforeView.layer;
        layer.zPosition = -4000;
//        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
//        rotationAndPerspectiveTransform.m34 = 1.0 / 300;
//        layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform, -10.0f * M_PI / 180.0f, 1.0f, 0.0f, 0.0f);
        self.beforeView.alpha = 1;
        self.beforeView.backgroundColor = [UIColor whiteColor];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
//            self.beforeView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            self.selectTypeView.frame = CGRectMake(0, self.view.frame.size.height  , self.view.frame.size.width, Screen_Height() *0.7);
        }];
    }];
}



#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.beforeView];
    [self.beforeView addSubview:self.tableView];
    WS(weakSelf);
    
    self.shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height , self.view.frame.size.width, 240)];
    [self.view addSubview:self.shareView];

    
    
    self.collectionType = NO;
#pragma mark - 加载第一次数据
    //加载第一次数据
    [[JXRequestManager sharedNetWorkManager] RequestViewMallProduceWithIdString:self.idString Success:^(NSDictionary *dic) {
        //转化成modelFrame  里面包括一部分的model数据
        //方便用于动态的计算header的高度
        weakSelf.singleModel = [SingleProductModel objectWithKeyValues:dic];
        weakSelf.frameModel = [[SingleProducrFrameModel alloc] init];
        //把model给frame中的singleProductModel
        weakSelf.frameModel.singleProductModel = weakSelf.singleModel;
        weakSelf.singleProductView.frameModel = self.frameModel;
        self.dataArray = self.frameModel.singleProductModel.mallProductDescribe;
        for (NSDictionary *dic in self.dataArray) {
            SingleCaluteGoodsModel *singleModel = [SingleCaluteGoodsModel objectWithKeyValues:dic];
            SingleGoodsFrameModel *frame = [[SingleGoodsFrameModel alloc] init];
            frame.singleModel = singleModel;
            [self.frameDataArray addObject:frame];
            weakSelf.singleBottomView.frameModel = self.frameModel;
            [self.tableView reloadData];
            
#pragma mark - 弹出的界面
            self.selectTypeView = [[SelectGoodsTypeView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height , self.view.frame.size.width, Screen_Height() *0.7) andFrameModel:self.frameModel];
            self.selectTypeView.backgroundColor = [UIColor whiteColor];
            self.selectTypeView.suretoBuyBlock = ^(NSString *mallProductSkuId, NSString *number){
                //选择跳转界面
                [weakSelf SelectGotoBuyCarOrPayOrLoginWithSelectTag:weakSelf.selectTag AndMallProductSkuId:mallProductSkuId andNumber:number];
            };
            
            //关闭弹出界面
            self.selectTypeView.dismissThePushViewBlock = ^(){
                [weakSelf showTheGoodsView];
            };
            
            [self.view addSubview:self.selectTypeView];
            weakSelf.selectTypeView.frameModel = self.frameModel;
        }

    } failture:^(NSString *errMsg) {
        
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTheGoodsView)];
    [self.beforeView addGestureRecognizer:tap];
   
//    [self PushSeletGoosTypeView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.frameDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    SingleGoodsViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[SingleGoodsViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SingleGoodsFrameModel *frmaeModel = [self.frameDataArray objectAtIndex:indexPath.row];
    cell.frameModel = frmaeModel;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SingleGoodsFrameModel *mainframe = [self.frameDataArray objectAtIndex:indexPath.row];
    return mainframe.cellHeight;
}


#pragma  mark - 懒加载
-(SingleProductView *)singleProductView
{
    if (!_singleProductView) {
        WS(weakSelf);
        _singleProductView = [[SingleProductView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), Screen_Width() + 250)];
        _singleProductView.backgroundColor = [UIColor whiteColor];
        _singleProductView.share_colletion_buycarBlock = ^(NSInteger tag) {
            if (tag == 1) {
                [weakSelf PushSeletGoosTypeView];
            } else if (tag == 3) {
                if (self.collectionType == NO) {
                    [[JXRequestManager sharedNetWorkManager] CrmUserLikeMallProductWithmallProductId:weakSelf.singleModel.id Success:^(NSDictionary *dic) {
                        [[weakSelf view] makeToast:@"收藏成功" duration:1 position:@"bottom"];
                        weakSelf.collectionType = YES;
                    } failture:^(NSString *errMsg) {
                        [[weakSelf view] makeToast:@"收藏失败" duration:1 position:@"bottom"];
                    }];
                } else if (self.collectionType == YES) {
                  [[JXRequestManager sharedNetWorkManager] CrmUserUnlikeMallProductWithmallProductId:weakSelf.singleModel.id Success:^(NSDictionary *orderDic) {
                      [[weakSelf view] makeToast:@"取消收藏成功" duration:1 position:@"bottom"];
                      weakSelf.collectionType = NO;
                  } failture:^(NSString *errMsg) {
                      [[weakSelf view] makeToast:@"取消收藏失败" duration:1 position:@"bottom"];
                  }];
                }
            } else if (tag == 2){
                [weakSelf favourite];
            }
        };
    }
    return _singleProductView;
}

-(NSMutableArray *)frameDataArray{
    if (!_frameDataArray) {
        _frameDataArray = [NSMutableArray array];
    }
    return _frameDataArray;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), Screen_Height() - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 120;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.singleProductView;
    }
    return _tableView;
}

#pragma mark - 判断就跳转到哪一个界面
-(void)SelectGotoBuyCarOrPayOrLoginWithSelectTag:(NSInteger)tag AndMallProductSkuId:(NSString *)mallProductSkuId andNumber:(NSString *)number{
    WS(weakSelf);
    if ([[NSUserDefaults standardUserDefaults] objectForKey:SaveTokenKey]){
//        if (tag == 1) {
//            [self dismissSemiModalView];
            BuyCarViewController *buyCar = [[BuyCarViewController alloc] init];
            [[JXRequestManager sharedNetWorkManager] AddToCartWithmallProductSkuId:mallProductSkuId andquantity:number Success:^(NSArray *orderArray) {
                [weakSelf.navigationController pushViewController:buyCar animated:YES];
            } failture:^(NSString *errMsg) {
            }];
//        } else if (tag == 2) {
//            [weakSelf dismissSemiModalView];
//            //去立即下单界面
//            PayGoodsViewController *payGoods = [[PayGoodsViewController alloc] init];
//            [[JXRequestManager sharedNetWorkManager] createOmSaleOrderWithmallSaleDetailId:mallProductSkuId Success:^(NSString *omSaleOrderHeaderId) {
//                payGoods.omSaleOrderHeaderId = omSaleOrderHeaderId;
//                [weakSelf.navigationController pushViewController:payGoods animated:YES];
//            } failture:^(NSString *errMsg) {
//                
//            }];
//        }
    }  else {
        //去登陆界面
        GuidanceLoginViewController *guidelogin = [[GuidanceLoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:guidelogin];
        [weakSelf presentViewController:nav animated:YES completion:nil];
    }
}

#pragma mark - --------
#pragma mark - 懒加载
//给所有主界面中的试图加一个主背景试图，方便进行控制
-(UIView *)beforeView{
    if (!_beforeView) {
        _beforeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), Screen_Height())];
        _beforeView.backgroundColor = [UIColor whiteColor];
        _beforeView.userInteractionEnabled = YES;
    }
    return _beforeView;
}

#pragma mark -分享
-(void)favourite{
    WS(weakSelf);
    [UIView animateWithDuration:1 animations:^{
        weakSelf.shareView.frame = CGRectMake(0, weakSelf.view.frame.size.height - 240 , weakSelf.view.frame.size.width, 240);
        CALayer *layer = weakSelf.beforeView.layer;
        layer.zPosition = -4000;
        weakSelf.beforeView.backgroundColor = [UIColor blackColor];
        weakSelf.beforeView.alpha = 0.8;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.beforeView.backgroundColor = [UIColor blackColor];
            weakSelf.beforeView.alpha = 0.8;
        }];
    }];

    
    self.shareView.wechatFriendblock = ^(){
        [[ShareModel sharedTheMeaasg] shareTheMessageToWeChatWithUrl:@"http://goujx.com" AndTitle:@"11" AndImage:@"http://image.baidu.com/search/detail?ct=503316480&z=undefined&tn=baiduimagedetail&ipn=d&word=tu&step_word=&ie=utf-8&in=&cl=2&lm=-1&st=undefined&cs=60414518,1130716184&os=2307950351,1067524309&pn=1&rn=1&di=3576465860&ln=1000&fr=&fmq=1438917873320_R&ic=undefined&s=undefined&se=&sme=&tab=0&width=&height=&face=undefined&is=0,0&istype=0&ist=&jit=&bdtype=0&gsm=0&objurl=http%3A%2F%2Fimg.kumi.cn%2Fphoto%2Fb4%2F70%2F80%2Fb47080e1c5ad4880.jpg" andDescription:@"11" AndType:@"1"];
    };
   
    self.shareView.wechatgroupblock =^(){
        [[ShareModel sharedTheMeaasg] shareTheMessageToWeChatWithUrl:@"http://goujx.com" AndTitle:@"11" AndImage:@"http://image.baidu.com/search/detail?ct=503316480&z=undefined&tn=baiduimagedetail&ipn=d&word=tu&step_word=&ie=utf-8&in=&cl=2&lm=-1&st=undefined&cs=60414518,1130716184&os=2307950351,1067524309&pn=1&rn=1&di=3576465860&ln=1000&fr=&fmq=1438917873320_R&ic=undefined&s=undefined&se=&sme=&tab=0&width=&height=&face=undefined&is=0,0&istype=0&ist=&jit=&bdtype=0&gsm=0&objurl=http%3A%2F%2Fimg.kumi.cn%2Fphoto%2Fb4%2F70%2F80%2Fb47080e1c5ad4880.jpg" andDescription:@"11" AndType:@"2"];
    };

    self.shareView.sinaShareBlock = ^(){
        [[ShareModel sharedTheMeaasg] shareTheMessageToWBWithUrl:@"http://goujx.com" AndTitle:@"11" AndImage:@"http://image.baidu.com/search/detail?ct=503316480&z=undefined&tn=baiduimagedetail&ipn=d&word=tu&step_word=&ie=utf-8&in=&cl=2&lm=-1&st=undefined&cs=60414518,1130716184&os=2307950351,1067524309&pn=1&rn=1&di=3576465860&ln=1000&fr=&fmq=1438917873320_R&ic=undefined&s=undefined&se=&sme=&tab=0&width=&height=&face=undefined&is=0,0&istype=0&ist=&jit=&bdtype=0&gsm=0&objurl=http%3A%2F%2Fimg.kumi.cn%2Fphoto%2Fb4%2F70%2F80%2Fb47080e1c5ad4880.jpg" andDescription:@"11"];
    };

    self.shareView.cancleblock = ^(){
        weakSelf.beforeView.userInteractionEnabled=YES;
        [UIView animateWithDuration:1 animations:^{
            CALayer *layer = weakSelf.beforeView.layer;
            layer.zPosition = -4000;
            weakSelf.beforeView.alpha = 1;
            weakSelf.beforeView.backgroundColor = [UIColor whiteColor];
            [UIView animateWithDuration:1 animations:^{
                weakSelf.shareView.frame = CGRectMake(0, 1000, weakSelf.view.frame.size.width, 240);
            }];
        } completion:^(BOOL finished) {
        }];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
