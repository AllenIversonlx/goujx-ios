




//
//  FMDBSingleton.m
//  HongDian
//
//  Created by 姜通 on 15/7/27.
//  Copyright (c) 2015年 姜通. All rights reserved.
//

#import "FMDBSingleton.h"

@implementation FMDBSingleton

+(FMDatabase*)getDateBase
{
//    NSFileManager*fileManager =[NSFileManager defaultManager];
//    NSError*error;
    NSArray*paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString*documentsDirectory =[paths objectAtIndex:0];
    NSString*txtPath =[documentsDirectory stringByAppendingPathComponent:@"CRM.db"];
//    if([fileManager fileExistsAtPath:txtPath]== NO)
//    {
//        NSString*resourcePath =[[NSBundle mainBundle] pathForResource:@"CRM" ofType:@"db"];
//        [fileManager copyItemAtPath:resourcePath toPath:txtPath error:&error];
//    }
    FMDatabase *db= [FMDatabase databaseWithPath:txtPath] ;
    // db = _datebase;
    if (![db open])
    {
        NSLog(@"Could not open db.");
    }
    return db;
}


+(void)InsertNewProductsWithDic:(NSDictionary *)dic{
    FMDatabase * db = [self getDateBase];
    [db executeUpdate:@"CREATE TABLE manual (Createdate text, CreateUser text, DataID text, DataName text, Flag text, HttpUrl text, Sort text, SuperCode int, SuperName text,SuperSort text,TypeCode int, TypeName text, TypeSort text)"];
    [db executeUpdate:@"DELETE FROM manual"];

    
    //[db executeUpdate:@"INSERT INTO manual (Createdate, CreateUser, DataID, DataName, Flag, HttpUrl, Sort, SuperCode, SuperName,SuperSort,TypeCode, TypeName, TypeSort) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?) ",createDate,createUser,dataID,dataName, flag,httpString,sort,superCode,superName,superSort,typeCode,typeName,typesort];
}


@end
