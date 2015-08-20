

//
//  AddNewAddressViewController.m
//  HongDian
//
//  Created by 姜通 on 15/7/22.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "AddNewAddressViewController.h"
#import "Config.h"
#import "JXRequestManager.h"
#import <MJExtension/MJExtension.h>
#import "UIButton+Utilis.h"
#import <Masonry/Masonry.h>
#import "JXRequestManager.h"
#import "UIButton+Utilis.h"
#import "Toast+UIView.h"

@interface AddNewAddressViewController ()

@end

@implementation AddNewAddressViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"收货人信息";
    [self.view addSubview:self.tableView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.provinceArray = [self.pickerDic allKeys];
    self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
    
    if (self.selectedArray.count > 0) {
        self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
    }
    
    if (self.cityArray.count > 0) {
        self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height(), Screen_Width(), 300)];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: self.backView];
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width,250)];
    self.pickerView.delegate = self;
    self.pickerView.showsSelectionIndicator=YES;
    self.pickerView.dataSource = self;
    [self.backView addSubview: self.pickerView];
    
    
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(10, 10, 60,40);
    cancleButton.titleLabel.font = LittleTextLabelFont;
    [cancleButton setTitleColor:ButtonColor forState:UIControlStateNormal];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.backView addSubview:cancleButton];
    cancleButton.tag = 100;
    [cancleButton addTarget:self action:@selector(cancleOrSureTheCity:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(Screen_Width() - 70, 10, 60,40);
    sureButton.titleLabel.font = LittleTextLabelFont;
    sureButton.tag = 101;
    [sureButton setTitleColor:ButtonColor forState:UIControlStateNormal];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(cancleOrSureTheCity:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:sureButton];
}

-(void)cancleOrSureTheCity:(UIButton *)btn{
    switch (btn.tag) {
        case 100:
        {
            [UIView animateWithDuration:1 animations:^{
                self.backView.frame = CGRectMake(0, Screen_Height(), Screen_Width(), 300);
            } completion:^(BOOL finished) {
                
            }];
            break;
        }
        case 101: {
            NSString *provinceString = [self.provinceArray objectAtIndex:[self.pickerView selectedRowInComponent:0]];
            NSString *cityString = [self.cityArray objectAtIndex:[self.pickerView selectedRowInComponent:1]];
            NSString *townString = [self.townArray objectAtIndex:[self.pickerView selectedRowInComponent:2]];
            self.cityLabel.text = [NSString stringWithFormat:@"%@ %@ %@",provinceString,cityString,townString];
            self.backView.frame = CGRectMake(0, Screen_Height(), Screen_Width(), 300);
            break;
        }
        default:
            break;
    }
}

-(void)selectTheCity{
    [UIView animateWithDuration:1 animations:^{
        self.backView.frame = CGRectMake(0, Screen_Height() - 300, Screen_Width(), 300);
    } completion:^(BOOL finished) {
      
    }];
}

#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.provinceArray objectAtIndex:row];
    } else if (component == 1) {
        return [self.cityArray objectAtIndex:row];
    } else {
        return [self.townArray objectAtIndex:row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 110;
    } else if (component == 1) {
        return 100;
    } else {
        return 110;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
        if (self.selectedArray.count > 0) {
            self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
        } else {
            self.cityArray = nil;
        }
        if (self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
        } else {
            self.townArray = nil;
        }
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if (component == 1) {
        if (self.selectedArray.count > 0 && self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:row]];
        } else {
            self.townArray = nil;
        }
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
    [pickerView reloadComponent:2];
}


#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 70;
    } else if (indexPath.row == 1) {
        return 70;
    } else if (indexPath.row == 2 ) {
        return 70;
    } else if (indexPath.row == 3) {
        return 120;
    } else
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    UIView *view = [[UIView alloc] init];
    [cell addSubview:view];
    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view.layer.borderWidth = 0.5;
    
    switch (indexPath.row) {
        case 0:
        {
            view.frame = CGRectMake(0, 0, Screen_Width(), 60);
            [view addSubview:self.nameTextField];
            [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(view.mas_centerY);
                make.left.equalTo(view.mas_left).offset(15);
                make.right.equalTo(view.mas_right).offset(-15);
            }];
            break;
        }
            
        case 1:
        {
            view.frame = CGRectMake(0, 0, Screen_Width(), 60);
            [view addSubview:self.phoneTextField];
            [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(view.mas_centerY);
                make.left.equalTo(view.mas_left).offset(15);
                make.right.equalTo(view.mas_right).offset(-15);
            }];
            break;
        }
        case 2:{
            view.frame = CGRectMake(0, 0, Screen_Width(), 60);
            [view addSubview:self.cityLabel];
            [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(view.mas_centerY);
                make.left.equalTo(view.mas_left).offset(15);
                make.right.equalTo(view.mas_right).offset(-15);
            }];
            break;
        }
        case 3:{
            view.frame = CGRectMake(0, 0, Screen_Width(), 110);
            [view addSubview:self.addressTextField];
            [self.addressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(view.mas_centerY);
                make.right.equalTo(view.mas_right).offset(-15);
                make.left.equalTo(view.mas_left).offset(15);
            }];
            break;
        }
            
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 120;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width(), 95)];
    self.savebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.savebutton setImage:[UIImage imageNamed:@"unselectImage"] forState:UIControlStateNormal];
    [self.savebutton setImage:[UIImage imageNamed:@"selectedImage"] forState:UIControlStateSelected];
    self.savebutton.tag = 100;
    [self.savebutton addTarget:self action:@selector(saveTheAddress:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.savebutton];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"默认收获地址";
    label.font = TextLabelFont;
    label.textColor = [UIColor lightGrayColor];
    [view addSubview:label];
    
    [self.savebutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top).offset(3);
        make.height.equalTo(@25);
        make.width.equalTo(@25);
        make.left.equalTo(@15);
    }];
    WS(weakSelf);

    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.savebutton.mas_right).offset(5);
        make.top.equalTo(view.mas_top).offset(5);
    }];
    
    UIButton *button = [UIButton borderbuttonWithTitleString:@"保存" andWithColor:ButtonColor];
    [view addSubview:button];
    button.tag = 200;
    [button addTarget:self action:@selector(saveTheAddress:) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top).offset(60);
        make.height.equalTo(@60);
        make.left.equalTo(@25);
        make.right.equalTo(@-25);
    }];
    return view;
}

-(void)saveTheAddress:(UIButton *)btn{
    switch (btn.tag) {
        case 100:
        {
            btn.selected = !btn.selected;
            break;
        }
        case 200:{
            [self SaveTheAddressAndPhone];
            break;
        }
        default:
            break;
    }
}


-(void)SaveTheAddressAndPhone{
    NSString *isdefault = @"1";
    if (self.savebutton.selected == YES) {
        isdefault = @"1";
    } else {
        isdefault = @"-1";
    }
    
    NSString *regex = @"[0-9]{11}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self.phoneTextField.text];
    if(! isMatch)
    {
        [[self view] makeToast:@"请输入正确手机号码" duration:1 position:@"bottom"];
        return;
    }
    
    if ([self.nameTextField.text isEqualToString:@""]) {
        [[self view] makeToast:@"请输入用户名" duration:1 position:@"bottom"];
        return;
    }
    
    if ([self.addressTextField.text isEqualToString:@""]) {
        [[self view] makeToast:@"请输入详细地址" duration:1 position:@"bottom"];
        return;
    }
    if ([self.cityLabel.text isEqualToString:@"省 市 区"]) {
        [[self view] makeToast:@"请选择城市" duration:1 position:@"bottom"];
        return;
    }
    
    [[JXRequestManager sharedNetWorkManager] CreateWmsShippingAddressWithDistrictID:@"659004" andAddress:self.addressTextField.text andShippingToName:self.nameTextField.text shippingToPhone:self.phoneTextField.text andisDefault:isdefault Success:^(id dictrictArray) {
        if (self.contentTheAddressBlcok) {
            self.contentTheAddressBlcok();
        }
        [[self view] makeToast:@"保存地址成功" duration:1 position:@"bottom"];
    } failture:^(NSString *errMsg) {
    
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [self.tableView endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.nameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.addressTextField resignFirstResponder];
    return YES;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,Screen_Width(), Screen_Height() - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _tableView;
}


-(UITextField *)nameTextField
{
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.placeholder = @"用户名";
        _nameTextField.delegate = self;
        _nameTextField.font = TextLabelFont;
    }
    return _nameTextField;
}


-(UITextField *)phoneTextField
{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.placeholder = @"手机号码";
        _phoneTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        _phoneTextField.delegate = self;
        _phoneTextField.font = TextLabelFont;
    }
    return _phoneTextField;
}

-(UITextField *)cityTextField
{
    if (!_cityTextField) {
        _cityTextField = [[UITextField alloc] init];
        _cityTextField.placeholder = @"省 市 区";
        _cityTextField.delegate = self;
        _cityTextField.font = TextLabelFont;
    }
    return _cityTextField;
}


-(UITextField *)addressTextField
{
    if (!_addressTextField) {
        _addressTextField = [[UITextField alloc] init];
        _addressTextField.placeholder = @"详细地址";
        _addressTextField.delegate = self;
        _addressTextField.font = TextLabelFont;
    }
    return _addressTextField;
}

-(UILabel *)cityLabel
{
    if (!_cityLabel) {
        _cityLabel = [[UILabel alloc] init];
        _cityLabel.text = @"省 市 区";
        _cityLabel.textColor = [UIColor lightGrayColor];
        _cityLabel.font = TextLabelFont;
        _cityLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTheCity)];
        [_cityLabel addGestureRecognizer:tap];
    }
    return _cityLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.nameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.addressTextField resignFirstResponder];
}



@end
