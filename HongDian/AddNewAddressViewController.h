//
//  AddNewAddressViewController.h
//  HongDian
//
//  Created by 姜通 on 15/7/22.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ContentTheAddressBlock) ();

@interface AddNewAddressViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
//@property (nonatomic, retain) NSMutableArray *provinceArray;

@property (nonatomic, retain) UITextField *nameTextField;
@property (nonatomic, retain) UITextField *phoneTextField;
@property (nonatomic, retain) UITextField *cityTextField;
@property (nonatomic, retain) UITextField *addressTextField;
@property (nonatomic, retain) UILabel *cityLabel;

@property (nonatomic, retain) UIButton *savebutton;
@property (nonatomic, retain) NSArray *provinceArray;
@property (nonatomic, retain) NSArray *cityArray;
@property (nonatomic, retain) NSArray *districtArray;
@property (strong, nonatomic) NSDictionary *pickerDic;
@property (strong, nonatomic) NSArray *townArray;
@property (strong, nonatomic) NSArray *selectedArray;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, retain) UIView *backView;

@property (nonatomic, copy) ContentTheAddressBlock contentTheAddressBlcok;

@end
