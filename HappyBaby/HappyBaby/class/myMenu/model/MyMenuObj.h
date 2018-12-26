//
//  MyMenuObj.h
//  HappyBaby
//
//  Created by feng on 2018/12/26.
//  Copyright © 2018 zhujunyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyMenuObj : NSObject

@property (nonatomic, assign) int menuID;
@property (nonatomic, retain) NSDate *time;
@property (nonatomic, copy) NSString *timeString;
@property (nonatomic, retain) NSMutableArray *menuArr;
@end

NS_ASSUME_NONNULL_END
