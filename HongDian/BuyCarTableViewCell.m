


//
//  BuyCarTableViewCell.m
//  HongDian
//
//  Created by 姜通 on 15/7/21.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "BuyCarTableViewCell.h"
#import "Config.h"
#import <Masonry/Masonry.h>
#import "MallProductSkuModel.h"
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface BuyCarTableViewCell ()<UIAlertViewDelegate>

@property (nonatomic, readwrite,strong) UIButton *btn_check;
//@property (nonatomic, strong) UIButton *btn_delete;
//@property (nonatomic, strong) UIView *backView;
//@property (nonatomic, strong) UIView *littleView;
//@property (nonatomic, strong) UIImageView *img_seperator;
//@property (nonatomic, strong) UIImageView *img_goods_image;
//@property (nonatomic, strong) UILabel *lb_goods_name;
//@property (nonatomic, strong) UILabel *lb_goods_brand;
//@property (nonatomic, strong) UILabel *lb_goods_price;
//@property (nonatomic, strong) UIButton *btn_add_one;
//@property (nonatomic, strong) UIButton *btn_minus_one;
//@property (nonatomic, strong) UILabel *lb_goods_count;
//@property (nonatomic, strong) UILabel *buyCountLabel;
//@property (nonatomic, strong) UIView *bigView;
//@property (nonatomic, assign) float totalfees;

//暂存
//@property (nonatomic, strong) BuyCarModel *model;
@end


@implementation BuyCarTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
        
        self.frame = CGRectMake(0, 0, Screen_Width(), CART_SHOW_CELL_HEIGHT);
    }
    return self;
}

-(BuyCarModel *)getbuyCarModel
{
    return self.buyCarModel;
}

- (void)applyModelValueWithModel:(BuyCarModel *)buyCarModel andCount:(int)count
{
    self.buyCarModel= buyCarModel;
    self.lb_goods_count.text = [NSString stringWithFormat:@"%@",buyCarModel.quantity];
    
    
    MallProductSkuModel *productSkuModel = [MallProductSkuModel objectWithKeyValues:buyCarModel.mallProductSku];
    
    self.mallProductSkuId = productSkuModel.id;

    MallProductModel *productModel = [MallProductModel objectWithKeyValues:productSkuModel.mallProduct];
    
    NSDictionary *dic = productModel.cover;
    [self.img_goods_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"absoluteMediaUrl"]]]];
    self.lb_goods_price.text = [NSString stringWithFormat:@" %.2f", [productModel.salePrice floatValue]];
    self.totalfees =  [productModel.salePrice floatValue];
    self.lb_goods_name.text = [NSString stringWithFormat:@"%@", productModel.name];
    if (productSkuModel.baseColor == nil) {
        self.lb_goods_brand.text = [NSString stringWithFormat:@"%@ ",productSkuModel.size ];
    }  else if (productSkuModel.size == nil) {
        self.lb_goods_brand.text = [NSString stringWithFormat:@"%@ ",productSkuModel.baseColor ];
    } else {
        self.lb_goods_brand.text = [NSString stringWithFormat:@"%@ |  %@",productSkuModel.size,productSkuModel.baseColor];
    }
}

#pragma mark - ButtonAction
//添加到结算
-(void)confirmToAdd:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (self.selectGoodsBlock) {
        float totalFees = 0;
        totalFees = self.totalfees;
        self.selectGoodsBlock(btn.selected, [NSString stringWithFormat:@"%.2f", totalFees * [self.lb_goods_count.text intValue]]);
    }
}

//删除一件商品
- (void)deleteOneGoods
{
    float totalFees = 0;
    totalFees = self.totalfees;
    if (self.deleteGoodsBlock) {
        self.deleteGoodsBlock(self.mallProductSkuId,self.lb_goods_count.text,self.buyCarModel,[NSString stringWithFormat:@"%.2f", totalFees * [self.lb_goods_count.text intValue]]);
    }
}

#pragma mark -  UIAlertViewDelegate
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确认删除此商品？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
//    [alertView show];

//    if (buttonIndex) {
//        WS(Cell);
//        if (self.deleteGoodsBlock) {
//            self.deleteGoodsBlock(self.buyCarModel.mallProductSkuId);
//        }
//    }
//}


//重写此方法 为了 让左上角的 选择按钮 更加 好 点击
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGRect rect = CGRectMake(0, 0, 40, 40);
    CGPoint point = [[touches anyObject]locationInView:self];
    if (CGRectContainsPoint(rect, point)) {
        [self confirmToAdd:self.btn_check];
        return;
    }
    //如果不调用super方法，tableView的代理方法不会响应
    [super touchesBegan:touches withEvent:event];
}

//后台图片大小限制到了50k
#pragma mark -
- (void)changeGoodsCount:(UIButton *)btn
{
    switch (btn.tag) {
        case 100:
        {
            int count = [self.lb_goods_count.text intValue];
            if (count <10) {// [self.model.skuModel.stock_num intValue]这里是取 添加之前 的库存量，具体是否 够量，交给后台处理
                count++;
            } else {
//                [SVProgressHUD showErrorWithStatus:@"不能购买更多了哟"];
                return;
            }
            self.lb_goods_count.text = [NSString stringWithFormat:@"%d", count];
            NSString * totalFees = [NSString stringWithFormat:@" %.2f",self.totalfees];
            self.lb_goods_price.text = [NSString stringWithFormat:@" %.2f",self.totalfees];
            if (self.addGoodsBlock) {
                self.addGoodsBlock(totalFees,self.mallProductSkuId,self.lb_goods_count.text,self.buyCarModel);
            }
            break;
        }
        case 101:
        {
            int count = [self.lb_goods_count.text intValue];
            if (count > 1) {
                count--;
            } else {
                return;
            }
            self.lb_goods_count.text = [NSString stringWithFormat:@"%d", count];
            NSString * totalFees =  [NSString stringWithFormat:@" %.2f",self.totalfees];
            self.lb_goods_price.text = [NSString stringWithFormat:@"%.2f",self.totalfees];
            if (self.minusGoodsBlock) {
                self.minusGoodsBlock(totalFees,self.mallProductSkuId,self.lb_goods_count.text,self.buyCarModel);
            }
            break;
        }
        default:
            break;
    }
}




- (void)setupSubviews
{
    [self.contentView addSubview:self.bigView];
//    [self.bigView addSubview:self.backView];
    [self.bigView addSubview:self.btn_check];
//    [self.bigView addSubview:self.btn_delete];
    [self.bigView addSubview:self.lb_goods_name];
    [self.bigView addSubview:self.img_goods_image];
    [self.bigView addSubview:self.lb_goods_price];
    [self.bigView addSubview:self.buyCountLabel];
    [self.bigView addSubview:self.btn_minus_one];
    [self.bigView addSubview:self.btn_add_one];
    [self.bigView addSubview:self.lb_goods_count];
    [self.bigView addSubview:self.lb_goods_brand];
    
    //layout
    WS(Cell);
    [_bigView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Cell.mas_left).offset(0);
        make.right.equalTo(Cell.mas_right).offset(0);
        make.top.equalTo(Cell.mas_top).offset(0);
        make.bottom.equalTo(Cell.mas_bottom).offset(-10);
    }];
    
    [_btn_check mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Cell.mas_top).offset(45);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        make.left.equalTo(Cell.mas_left).offset(15);
    }];
//
//    [_btn_delete mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(Cell.mas_top).offset(10);
//        make.right.equalTo(@-10);
//        make.width.equalTo(@60);
//        make.height.equalTo(@30);
//    }];
//    
//    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_btn_check.mas_bottom).offset(10);
//        make.width.equalTo(Cell.mas_width);
//        make.height.equalTo(@120);
//    }];
//
    [_img_goods_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bigView.mas_top).offset(5);
        make.left.equalTo(_btn_check.mas_right).offset(10);
        make.width.equalTo(@108);
        make.height.equalTo(@108);
    }];

    [_lb_goods_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bigView.mas_top).offset(8);
        make.left.equalTo(_img_goods_image.mas_right).offset(7);
        make.right.equalTo(@-15);
    }];
    
    [_lb_goods_brand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lb_goods_name.mas_bottom).offset(5);
        make.left.equalTo(_img_goods_image.mas_right).offset(7);
        make.right.equalTo(@-15);
    }];

    [_lb_goods_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lb_goods_name.mas_bottom).offset(5);
        make.right.equalTo(@-5);
    }];

    [_btn_add_one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@33);
        make.height.equalTo(@33);
        make.right.equalTo(Cell.mas_right).offset(-15);
        make.bottom.equalTo(_bigView.mas_bottom).offset(-10);
    }];
    
    [_lb_goods_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_btn_add_one.mas_left).offset(0);
        make.width.equalTo(@33);
        make.height.equalTo(@33);
        make.bottom.equalTo(_bigView.mas_bottom).offset(-10);
    }];
    
    [_btn_minus_one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@33);
        make.height.equalTo(@33);
        make.right.equalTo(_lb_goods_count.mas_left).offset(0);
        make.bottom.equalTo(_bigView.mas_bottom).offset(-10);
    }];
    
    [_buyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_bigView.mas_bottom).offset(-15);
        make.right.equalTo(_btn_minus_one.mas_left).offset(-15);
    }];
    

}


#pragma mark - getters
- (UIButton *)btn_check
{
    if (!_btn_check) {
        _btn_check = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_check setImage:[UIImage imageNamed:@"unselectImage"] forState:UIControlStateNormal];
        [_btn_check setImage:[UIImage imageNamed:@"selectedImage"] forState:UIControlStateSelected];
        [_btn_check addTarget:self action:@selector(confirmToAdd:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_check;
}

- (UIButton *)btn_delete
{
    if (!_btn_delete) {
        _btn_delete = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_delete setTitle:@"删除" forState:UIControlStateNormal];
        [_btn_delete setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_btn_delete setTitleColor:ThemeFontColor forState:UIControlStateNormal];
        [_btn_delete sizeToFit];
        //add action
        [_btn_delete addTarget:self action:@selector(deleteOneGoods) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_delete;
}

- (UIImageView *)img_seperator
{
    if (!_img_seperator) {
        _img_seperator = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    }
    return _img_seperator;
}

- (UIImageView *)img_goods_image
{
    if (!_img_goods_image) {
        _img_goods_image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        _img_goods_image.contentMode = UIViewContentModeScaleAspectFit;
//        _img_goods_image.layer.borderWidth = 1;
//        _img_goods_image.layer.borderColor = [UIColor blackColor].CGColor;
    }
    return _img_goods_image;
}

- (UILabel *)lb_goods_name
{
    if (!_lb_goods_name) {
        _lb_goods_name = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
        _lb_goods_name.font = LittleTextLabelFont;
        _lb_goods_name.textAlignment = NSTextAlignmentLeft;
        _lb_goods_name.textColor = BuyCarNameColor;
        _lb_goods_name.numberOfLines = 0;
    }
    return _lb_goods_name;
}

- (UILabel *)lb_goods_brand
{
    if (!_lb_goods_brand) {
        _lb_goods_brand = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 18)];
        _lb_goods_brand.font = LittleTextLabelFont;
        _lb_goods_brand.textAlignment = NSTextAlignmentLeft;
        _lb_goods_brand.textColor = CancleNomalColer;
    }
    return _lb_goods_brand;
}

- (UILabel *)lb_goods_count
{
    if (!_lb_goods_count) {
        _lb_goods_count = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        _lb_goods_count.layer.borderColor = CancleNomalColer.CGColor;
        _lb_goods_count.layer.borderWidth = 0.5;
        _lb_goods_count.textAlignment = NSTextAlignmentCenter;
        _lb_goods_count.textColor = [UIColor blackColor];
     }
    return _lb_goods_count;
}

- (UILabel *)lb_goods_price
{
    if (!_lb_goods_price) {
        _lb_goods_price = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
        _lb_goods_price.font = TextLabelFont;
        _lb_goods_price.textAlignment = NSTextAlignmentLeft;
        _lb_goods_price.textColor = ButtonColor;
    }
    return _lb_goods_price;
}

- (UIButton *)btn_add_one
{
    if (!_btn_add_one) {
        _btn_add_one = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_add_one.backgroundColor = [UIColor whiteColor];
        _btn_add_one.frame = CGRectMake(0, 0, 20, 20);
        [_btn_add_one setTitle:@"+" forState:UIControlStateNormal];
        [_btn_add_one setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn_add_one addTarget:self action:@selector(changeGoodsCount:) forControlEvents:UIControlEventTouchUpInside];
        _btn_add_one.layer.borderColor = CancleNomalColer.CGColor;
        _btn_add_one.layer.borderWidth = 0.5;
        _btn_add_one.tag = 100;
    }
    return _btn_add_one;
}

- (UIButton *)btn_minus_one
{
    if (!_btn_minus_one) {
        _btn_minus_one = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_minus_one.backgroundColor =  [UIColor whiteColor];
        _btn_minus_one.frame = CGRectMake(0, 0, 20, 20);
        [_btn_minus_one setTitle:@"-" forState:UIControlStateNormal];
        [_btn_minus_one setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn_minus_one addTarget:self action:@selector(changeGoodsCount:) forControlEvents:UIControlEventTouchUpInside];
        _btn_minus_one.layer.borderColor = CancleNomalColer.CGColor;
        _btn_minus_one.layer.borderWidth = 0.5;
        _btn_minus_one.tag = 101;
    }
    return _btn_minus_one;
}


-(UILabel *)buyCountLabel
{
    if (!_buyCountLabel) {
        _buyCountLabel = [[UILabel alloc] init];
        _buyCountLabel.textColor = CancleNomalColer;
        _buyCountLabel.text = @"数量";
        _buyCountLabel.font = LittleTextLabelFont;
    }
    return _buyCountLabel;
}

-(UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.layer.borderColor = CancleNomalColer.CGColor;
        _backView.layer.borderWidth = 1;
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

-(UIView *)bigView
{
    if (!_bigView) {
        _bigView = [[UIView alloc] init];
        _bigView.layer.borderColor = CancleNomalColer.CGColor;
        _bigView.layer.borderWidth = 0.5;
        _bigView.backgroundColor = [UIColor whiteColor];
    }
    return _bigView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
