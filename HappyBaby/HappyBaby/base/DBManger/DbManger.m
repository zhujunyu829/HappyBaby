//
//  DbManger.m
//  HappyBaby
//
//  Created by feng on 2018/12/26.
//  Copyright © 2018 zhujunyu. All rights reserved.
//

#import "DbManger.h"
#import "FMDB.h"
#import "FoodObj.h"
#import "MenuObj.h"
#import "MyMenuObj.h"

@interface DbManger()
{
    FMDatabase *_db;
}
@property (nonatomic, copy, readonly) NSString * filePath;
@end

@implementation DbManger
static DbManger *manger = nil;
+ (instancetype)sharManger{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[DbManger alloc] init];
    });
    return manger;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        _db = [FMDatabase databaseWithPath:self.filePath];
    }
    return self;
}
- (void)creatDB{
    [_db open];
    [_db executeUpdate:@"create table if not exists my_menu_table(my_menu_id INTEGER PRIMARY KEY autoincrement,time datetime);"];
    [_db executeUpdate:@"create table if not exists menu(menu_id INTEGER  PRIMARY KEY autoincrement, name TEXT);"];
    [_db executeUpdate:@"create table if not exists food(food_id INTEGER PRIMARY KEY autoincrement,weight INTEGER,name TEXT,price INTEGER);"];
    [_db executeUpdate:@"create table if not exists menu_data(my_menu_id INTEGER,menu_id INTEGER);"];
    [_db executeUpdate:@"create table if not exists men_food(menu_id INTEGER,food_id INTEGER);"];
     [_db close];
    FoodObj *m = [FoodObj new];
    m.name = @"萝卜dd1";
    m.price = 10;
    m.weight = 1;
    [self insertFood:m];
}
- (NSString *)filePath{
    return [FileManger getPath:DBName atDirectior:WRDocumentsPath];
}
#pragma mark - food
- (BOOL)insertFood:(FoodObj *)mode{
    BOOL success = NO;
    if ([_db open]) {
        
      FMResultSet *resultSet = [_db executeQueryWithFormat:@"SELECT * FROM food WHERE name ='%@'",mode.name];
        if ([resultSet next]) {

        }else{
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO food (weight,name,price) values (%f,'%@',%f)",mode.weight,mode.name,mode.price];
          success = [_db executeUpdate:sql];
        }
        [_db close];
    }
    return success;
}
- (BOOL)updateFood:(FoodObj *)model{
    BOOL success = NO;
    if ([_db open]) {
        
       
    }
    return success;
}
#pragma mark - Menu
- (BOOL)insertMenu:(MenuObj *)mode{
    BOOL success = NO;
    if ([_db open]) {
        
        FMResultSet *resultSet = [_db executeQueryWithFormat:@"SELECT * FROM food WHERE datetime ='%@'",mode.name];
        if ([resultSet next]) {
            
        }else{
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO food (datetime) values ('%@')",mode.name];
            success = [_db executeUpdate:sql];
        }
        [_db close];
    }
    return success;
}
#pragma mark - myMenu
- (BOOL)insertMyMenu:(MyMenuObj *)mode{
    BOOL success = NO;
    if ([_db open]) {
        
        FMResultSet *resultSet = [_db executeQueryWithFormat:@"SELECT * FROM food WHERE name ='%f'",[mode.time timeIntervalSince1970]];
        if ([resultSet next]) {
            
        }else{
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO food (name) values ('%f')",[mode.time timeIntervalSince1970]];
            success = [_db executeUpdate:sql];
        }
        [_db close];
    }
    return success;
}

@end
