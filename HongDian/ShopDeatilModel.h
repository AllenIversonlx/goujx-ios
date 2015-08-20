//
//  ShopDeatilModel.h
//  HongDian
//
//  Created by 姜通 on 15/7/28.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopDeatilModel : NSObject
/*
 {
 baseWeather = "\U6674";
 cover =     {
 absoluteMediaUrl = "http://image.dev.goujx.com/MallSaleHeader/cover/20150814/1b145144e56bf5fe155655addc668852.jpg";
 mediaHeight = 660;
 mediaWidth = 440;
 type = image;
 };
 describe = "Angelababy\Uff0c\U4e2d\U6587\U540d";
 displayDate = "2015-08-14";
 id = 1;
 likeCount = 10;
 mallSaleDetail =     (
 {
 describe = "\U8fd9\U4e2a\U5e94\U8be5\U6709\U4ea7\U54c1";
 image =             {
 absoluteMediaUrl = "http://image.dev.goujx.com/MallSaleDetail/image/20150814/7a2859aa09b4a6855c1c1e725fac8ea8.jpg";
 mediaHeight = 689;
 mediaWidth = 440;
 type = image;
 };
 mallProductId = 4;
 },
 {
 describe = "";
 image =             {
 absoluteMediaUrl = "http://image.dev.goujx.com/MallSaleDetail/image/20150814/bd03d0005100bf8a3bbff6e3e293e97c.jpg";
 mediaHeight = 800;
 mediaWidth = 533;
 type = image;
 };
 mallProductId = "<null>";
 },
 {
 describe = "";
 image =             {
 absoluteMediaUrl = "http://image.dev.goujx.com/MallSaleDetail/image/20150814/901021b946e68bf25d1d88a49c1695b9.jpg";
 mediaHeight = 633;
 mediaWidth = 495;
 type = image;
 };
 mallProductId = "<null>";
 },
 {
 describe = "";
 image =             {
 absoluteMediaUrl = "http://image.dev.goujx.com/MallSaleDetail/image/20150814/cab6721ec71b9cd8b3ff0db4393685ee.jpg";
 mediaHeight = 660;
 mediaWidth = 440;
 type = image;
 };
 mallProductId = "<null>";
 },
 {
 describe = "";
 image =             {
 absoluteMediaUrl = "http://image.dev.goujx.com/MallSaleDetail/image/20150814/26d90f5fba911494d816a24e7a218696.jpg";
 mediaHeight = 660;
 mediaWidth = 440;
 type = image;
 };
 mallProductId = "<null>";
 },
 {
 describe = "";
 image =             {
 absoluteMediaUrl = "http://image.dev.goujx.com/MallSaleDetail/image/20150814/283517c5bf1c23c8745d6b1a20c4c2c8.jpg";
 mediaHeight = 677;
 mediaWidth = 440;
 type = image;
 };
 mallProductId = "<null>";
 }
 );
 name = "AB SUPER WAHAHA";
 readCount = 10;
 }

 */
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *describe;
@property (nonatomic, copy) NSString *displayOrder;
@property (nonatomic, copy) NSString *displayDate;
@property (nonatomic, copy) NSString *baseWeatherKey;
@property (nonatomic, copy) NSString *baseWeather;
@property (nonatomic, copy) NSString *likeCount;

@property (nonatomic, copy) NSString *readCount;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSDictionary *cover;

@property (nonatomic, strong) NSArray *mallSaleDetail;

@end
