//
//  DbManger.h
//  HappyBaby
//
//  Created by feng on 2018/12/26.
//  Copyright © 2018 zhujunyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodObj.h"
#import "MenuObj.h"
#import "MyMenuObj.h"
NS_ASSUME_NONNULL_BEGIN
#define DBName @"HappyBaby.sqlite3"

@interface DbManger : NSObject

+ (instancetype)sharManger;
- (void)creatDB;

/**
 获取菜单

 @param date 日期
 @return 返回菜单对象。如果没查到将会向数据库中插入当天数据
 */
- (MyMenuObj *)getMyMenuDate:(NSDate *)date;

/**
 查询所有菜单

 @return 所有菜单
 */
- (NSArray *)getAllMenu;

/**
 查询所有食材

 @return 所有食材
 */
- (NSArray *)getAllFood;

/**
 添加食材

 @param mode food对象
 @return YES 成功 NO 失败
 */
- (BOOL)insertFood:(FoodObj *)mode;
@end

NS_ASSUME_NONNULL_END
