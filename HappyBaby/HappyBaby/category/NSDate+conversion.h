//
//  NSDate+conversion.h
//  HappyBaby
//
//  Created by feng on 2018/12/27.
//  Copyright © 2018 zhujunyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (conversion)
-(NSInteger)firstWeekDayInMonth;
+(NSDate *)dateStartOfWeek;

-(NSInteger)year;
-(NSInteger)month;
-(NSInteger)day;
-(NSInteger)week;
-(NSDate *)offsetMonth:(int)numMonths;
-(NSDate *)offsetDay:(int)numDays;
-(NSDate *)offsetHours:(int)hours;

- (NSString *)coverToYYYYMMDDW;
- (NSString *)coverToYYYYMMDD;
- (NSDate *)changeToDay;
@end

NS_ASSUME_NONNULL_END
