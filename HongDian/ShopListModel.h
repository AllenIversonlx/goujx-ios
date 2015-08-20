//
//  ShopListModel.h
//  HongDian
//
//  Created by 姜通 on 15/8/18.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopListModel : NSObject

/*
 cover =                 {
 absoluteMediaUrl = "http://image.goujx.com/goods/2015081412155092623.jpg";
 mediaHeight = "<null>";
 mediaWidth = "<null>";
 type = image;
 };
 id = 5062;
 name = "FUSSED\U767d\U4e0d\U5bf9\U79f0\U9614\U6446\U96ea\U7eba\U4e0a\U8863";
 salePrice = "380.00";
 */


@property (nonatomic, retain) NSDictionary *cover;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *salePrice;

 @end
