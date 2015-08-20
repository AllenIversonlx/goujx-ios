//
//  FMDBSingleton.h
//  HongDian
//
//  Created by 姜通 on 15/7/27.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <FMDB/FMDatabase.h>

@interface FMDBSingleton : NSObject

+(FMDatabase*)getDateBase;


@end
