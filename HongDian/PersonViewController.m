//


//  PersonViewController.m
//  HongDian
//
//  Created by 姜通 on 15/8/10.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "PersonViewController.h"
#import "PersonTableViewCell.h"
#import "Config.h"
#import <Masonry/Masonry.h>
#import "UIButton+Utilis.h"
#import "PayModel.h"
#import <MJExtension/MJExtension.h>
#import "SelectAddressViewController.h"
#import "ChangePhotoOrImageView.h"
#import "JXRequestManager.h"
#import "ChangeNickNameViewController.h"
#import "Toast+UIView.h"

@interface PersonViewController ()
@property (nonatomic, retain) ChangePhotoOrImageView *changePhotoView;
@end

@implementation PersonViewController


-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"账户设置";
    self.array = @[@{@"name":@"更改头像",@"image":@"sheSay_icon"},@{@"name":@"修改昵称",@"image":@"nickname_icon"},@{@"name":@"我的收货地址",@"image":@"address_icon"}];
    for (NSDictionary *dic in self.array) {
        PayModel *payModel = [PayModel objectWithKeyValues:dic];
        [self.dataArray addObject:payModel];
    }
    [self.view addSubview:self.tableView];
    
    self.changePhotoView = [[ChangePhotoOrImageView alloc] initWithFrame:CGRectMake(0, Screen_Height(), Screen_Width(), 180)];
    [self.view addSubview:self.changePhotoView];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            WS(weakSelf);
            [UIView animateWithDuration:1 animations:^{
                weakSelf.changePhotoView.frame = CGRectMake(0, weakSelf.view.frame.size.height - 180 , weakSelf.view.frame.size.width, 180);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 animations:^{
                }];
            }];
            
            self.changePhotoView.selectWhichTypeUseImageBlock = ^(){
                [weakSelf takePhoto];
            };
            self.changePhotoView.selectWhichTypeUsePhotoBlock = ^(){
                [weakSelf LocalPhoto];
            };
            
            self.changePhotoView.selectWhichTypeUsecancleBlock = ^(){
                [UIView animateWithDuration:1 animations:^{
                    [UIView animateWithDuration:1 animations:^{
                        weakSelf.changePhotoView.frame = CGRectMake(0, 1000, weakSelf.view.frame.size.width, 240);
                    }];
                } completion:^(BOOL finished) {
                }];
            };

            break;
        }
        case 1:{
            ChangeNickNameViewController *changeNickVC = [[ChangeNickNameViewController alloc] init];
            [self.navigationController pushViewController:changeNickVC animated:YES];
            break;
        }
        case 2:{
            SelectAddressViewController *selectVC = [[SelectAddressViewController alloc] init];
            [self.navigationController pushViewController:selectVC animated:YES];
            break;
        }
        default:
            break;
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    viewController.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    viewController.navigationController.navigationBar.barTintColor = ButtonColor;
}


#pragma mark - 从相册选取
-(void)LocalPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择图片后可以编辑
    picker.allowsEditing = YES;
    picker.navigationBar.backgroundColor = [UIColor blackColor];
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - 照相
-(void)takePhoto{
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        picker.navigationBar.backgroundColor = [UIColor blackColor];
        
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        NSLog(@"该设备无摄像头");
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *headPhotoImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//        self.headImageView.image = headPhotoImage;
        [[JXRequestManager sharedNetWorkManager] actionUpdateCrmUserImage:headPhotoImage success:^(NSDictionary *dic) {
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
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    PersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[PersonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.payModel = self.dataArray[indexPath.row];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 95;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 95)];
    UIButton *loginOutButton = [UIButton borderbuttonWithTitleString:@"退出登陆" andWithColor: LoginOutColor];
    [loginOutButton addTarget:self action:@selector(LoginOut:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:loginOutButton];
    [loginOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top).offset(35);
        make.height.equalTo(@60);
        make.left.equalTo(@25);
        make.right.equalTo(@-25);
    }];
    return view;
}

-(void)LoginOut:(UIButton *)btn{

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), Screen_Height()) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
