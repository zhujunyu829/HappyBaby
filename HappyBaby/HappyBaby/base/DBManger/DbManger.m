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
    FMDatabaseQueue *_dbQueue;

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
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:self.filePath];

    }
    return self;
}
- (void)creatDB{
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        [db executeUpdate:@"create table if not exists my_menu_table(my_menu_id INTEGER PRIMARY KEY autoincrement,time datetime);"];
        [db executeUpdate:@"create table if not exists menu(menu_id INTEGER  PRIMARY KEY autoincrement, name TEXT);"];
        [db executeUpdate:@"create table if not exists food(food_id INTEGER PRIMARY KEY autoincrement,weight INTEGER,name TEXT,price INTEGER);"];
        [db executeUpdate:@"create table if not exists menu_data(time datetime ,menu_id INTEGER);"];
        [db executeUpdate:@"create table if not exists men_food(menu_id INTEGER,food_id INTEGER);"];
    }];
   
    FoodObj *m = [FoodObj new];
    m.name = @"萝卜dd1";
    m.price = 10;
    m.weight = 1;
    m.objID = 1;
    
    MenuObj *me = [MenuObj new];
    me.name = @"清炒萝卜";
    me.objID = 1;
    me.foodArr = [[NSMutableArray alloc] initWithArray:@[m]];
    [self insertFood:m inMenu:me];
    MyMenuObj *my = [MyMenuObj new];
    my.time = [[NSDate dateStartOfWeek] changeToDay];
    my.menuArr = [[NSMutableArray alloc] initWithArray:@[my]];
    [self insertMenu:me inMyMenu:my];
}
- (NSString *)filePath{
    return [FileManger getPath:DBName atDirectior:WRDocumentsPath];
}
#pragma mark - food
- (BOOL)insertFood:(FoodObj *)mode{
  __block  BOOL success = NO;
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *resultSet = [db executeQueryWithFormat:@"SELECT * FROM food WHERE name ='%@'",mode.name];
        if ([resultSet next]) {
            [resultSet close];
        }else{
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO food (weight,name,price) values (%f,'%@',%f)",mode.weight,mode.name,mode.price];
            success = [db executeUpdate:sql];
        }
    }];
   
    return success;
}
- (BOOL)updateFood:(FoodObj *)model{
    BOOL success = NO;
  
    return success;
}
#pragma mark - Menu
- (BOOL)insertMenu:(MenuObj *)mode{
    __block BOOL success = NO;
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *resultSet = [db executeQueryWithFormat:@"SELECT * FROM menu WHERE name ='%@'",mode.name];
        if ([resultSet next]) {
            [resultSet close];
        }else{
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO menu (name) values ('%@')",mode.name];
            success = [db executeUpdate:sql];
        }
    }];
   
    return success;
}
- (BOOL )insertFood:(FoodObj *)food inMenu:(MenuObj *)menu{
    __block BOOL success = NO;
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *resultSet = [db executeQueryWithFormat:@"SELECT * FROM men_food WHERE menu_id =%d and food_id =%d",menu.objID,food.objID];
        if ([resultSet next]) {
            [resultSet close];
        }else{
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO men_food (menu_id,food_id) values (%d,%d)",menu.objID,food.objID];
            success = [db executeUpdate:sql];
        }
    }];
    return success;
}
#pragma mark - myMenu
- (BOOL )insertMenu:(MenuObj *)menu inMyMenu:(MyMenuObj *)myM{
    __block BOOL success = NO;
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString *seleSql = [NSString stringWithFormat:@"SELECT * FROM menu_data WHERE time ='%f' and menu_id =%d",[myM.time timeIntervalSince1970],menu.objID];
        FMResultSet *resultSet = [db executeQuery:seleSql];
        if ([resultSet next]) {
            [resultSet close];
        }else{
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO menu_data (time,menu_id) values ('%f',%d)",[myM.time timeIntervalSince1970],menu.objID];
            success = [db executeUpdate:sql];
        }
    }];
    return success;
}
- (BOOL)insertMyMenu:(MyMenuObj *)mode{
    __block BOOL success = NO;
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *resultSet = [db executeQueryWithFormat:@"SELECT * FROM my_menu_table WHERE time ='%f'",[mode.time timeIntervalSince1970]];
        if ([resultSet next]) {
            [resultSet close];
        }else{
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO my_menu_table (time) values ('%f')",[mode.time timeIntervalSince1970]];
            success = [db executeUpdate:sql];
        }
    }];
   
    return success;
}
- (MyMenuObj *)getMyMenuDate:(NSDate *)date{
   __block MyMenuObj *obj = [MyMenuObj new];
    obj.time = date;
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSTimeInterval time = [obj.time timeIntervalSince1970];
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM my_menu_table WHERE time ='%f';",time];
        FMResultSet *resultSet = [db executeQuery:sql];
        if ([resultSet next]) {
            [resultSet close];
            NSString *getSql = [NSString stringWithFormat:@"SELECT food.* FROM my_menu_table LEFT JOIN menu_data ON my_menu_table.time= menu_data.time LEFT JOIN food ON food.food_id = menu_data.menu_id WHERE my_menu_table.time ='%f';",time];
           FMResultSet *result = [db executeQuery:getSql];
            NSMutableArray *arr = [NSMutableArray new];
            while ([result next]) {
                MenuObj *m = [MenuObj new];
                m.objID = [result intForColumn:@"food_id"];
                m.name = [result stringForColumn:@"name"];
                [arr addObject:m];
            }
            [result close];
            obj.menuArr = arr;
        }else{
            NSString *insetSql = [NSString stringWithFormat:@"INSERT INTO my_menu_table (time) values ('%f');",time];
            [db executeUpdate:insetSql];
        }
    }];
    
    return obj;
}
@end
