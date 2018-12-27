//
//  NSDate+conversion.m
//  HappyBaby
//
//  Created by feng on 2018/12/27.
//  Copyright © 2018 zhujunyu. All rights reserved.
//

#import "NSDate+conversion.h"

@implementation NSDate (conversion)
-(NSInteger)firstWeekDayInMonth{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:2]; //monday is first day
    //[gregorian setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
    
    //Set date to first of month
    NSDateComponents *comps = [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay fromDate:self];
    [comps setDay:1];
    NSDate *newDate = [gregorian dateFromComponents:comps];
    
    if ([gregorian ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfYear forDate:newDate] == 7) {
        return 0;
    }
    return [gregorian ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfYear forDate:newDate];
}

+(NSDate *)dateStartOfWeek {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: - ((([components weekday] - [gregorian firstWeekday])
                                      + 7 ) % 7)];
    NSDate *beginningOfWeek = [gregorian dateByAddingComponents:componentsToSubtract toDate:[NSDate date] options:0];
    
    NSDateComponents *componentsStripped = [gregorian components: (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                        fromDate: beginningOfWeek];
    
    //gestript
    beginningOfWeek = [gregorian dateFromComponents: componentsStripped];
    
    return beginningOfWeek;
}

-(NSInteger)year{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear fromDate:self];
    return [components year];
}
-(NSInteger)month{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear fromDate:self];
    return [components month];
}
-(NSInteger)day{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear fromDate:self];
    return [components day];
}
-(NSInteger)week{
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps;
    comps =[calendar components:(NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday |NSCalendarUnitWeekdayOrdinal)
                       fromDate:self];
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    return weekday;
}
-(NSDate *)offsetMonth:(int)numMonths{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    //[offsetComponents setMinute:30];
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}
-(NSDate *)offsetDay:(int)numDays{
    NSCalendar *gregorian = [[NSCalendar alloc]
                              initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}
-(NSDate *)offsetHours:(int)hours{
    NSCalendar *gregorian = [[NSCalendar alloc]
                              initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:hours];
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}
- (NSString *)coverToYYYYMMDDW{
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"YYYY年MM月dd日 EEEE"];
    return [f stringFromDate:self];
}
- (NSString *)coverToYYYYMMDD{
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"YYYY年MM月dd日"];
    return [f stringFromDate:self];
}
- (NSDate *)changeToDay{
    NSString *timeString = [self coverToYYYYMMDD];
    timeString = [timeString stringByAppendingString:@"09:00:00"];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"YYYY年MM月dd日hh:mm:ss"];
    return [f dateFromString:timeString];
}
@end
