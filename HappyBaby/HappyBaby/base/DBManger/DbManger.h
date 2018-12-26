//
//  DbManger.h
//  HappyBaby
//
//  Created by feng on 2018/12/26.
//  Copyright © 2018 zhujunyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define DBName @"HappyBaby.sqlite3"

@interface DbManger : NSObject

+ (instancetype)sharManger;
- (void)creatDB;
@end

NS_ASSUME_NONNULL_END
