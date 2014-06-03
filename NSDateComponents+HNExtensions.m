//
//  NSDateComponents+HNExtensions.m
//
//  The MIT License (MIT)
//
//  Copyright (c) 2013 Henri Normak
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "NSDateComponents+HNExtensions.h"
#define  NSDateComponentsHNExtensionsString(key, comment) NSLocalizedStringFromTable(key, NSDateComponentsHNExtensionsStringsTable, comment)

// Ignore incomplete implementation warning, as it is likely caused by the potential swizzling needed
@implementation NSDateComponents (HNExtensions)

- (void)hnextensions_setValue:(NSInteger)value forComponent:(NSCalendarUnit)unit {
    switch (unit) {
        case NSCalendarUnitEra:
            self.era = value;
            break;
        case NSCalendarUnitYear:
            self.year = value;
            break;
        case NSCalendarUnitMonth:
            self.month = value;
            break;
        case NSCalendarUnitDay:
            self.day = value;
            break;
        case NSCalendarUnitHour:
            self.hour = value;
            break;
        case NSCalendarUnitMinute:
            self.minute = value;
            break;
        case NSCalendarUnitSecond:
            self.second = value;
            break;
        case NSCalendarUnitWeekday:
            self.weekday = value;
            break;
        case NSCalendarUnitWeekdayOrdinal:
            self.weekdayOrdinal = value;
            break;
        case NSCalendarUnitQuarter:
            self.quarter = value;
            break;
        case NSCalendarUnitWeekOfMonth:
            self.weekOfMonth = value;
            break;
        case NSCalendarUnitWeekOfYear:
            self.weekOfYear = value;
            break;
        case NSCalendarUnitYearForWeekOfYear:
            self.yearForWeekOfYear = value;
            break;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 1070 || __NSCALENDAR_COND_IOS_5_0
        case NSCalendarUnitNanosecond:
            self.nanosecond = value;
            break;
#endif
        default:
            [NSException raise:NSInvalidArgumentException format:@"unit %lu is invalid", (unsigned long)unit];
            break;
    }
}

- (NSInteger)hnextensions_valueForComponent:(NSCalendarUnit)unit {
    switch (unit) {
        case NSCalendarUnitEra:
            return self.era;
        case NSCalendarUnitYear:
            return self.year;
        case NSCalendarUnitMonth:
            return self.month;
        case NSCalendarUnitDay:
            return self.day;
        case NSCalendarUnitHour:
            return self.hour;
        case NSCalendarUnitMinute:
            return self.minute;
        case NSCalendarUnitSecond:
            return self.second;
        case NSCalendarUnitWeekday:
            return self.weekday;
        case NSCalendarUnitWeekdayOrdinal:
            return self.weekdayOrdinal;
        case NSCalendarUnitQuarter:
            return self.quarter;
        case NSCalendarUnitWeekOfMonth:
            return self.weekOfMonth;
        case NSCalendarUnitWeekOfYear:
            return self.weekOfYear;
        case NSCalendarUnitYearForWeekOfYear:
            return self.yearForWeekOfYear;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 1070 || __NSCALENDAR_COND_IOS_5_0
        case NSCalendarUnitNanosecond:
            return self.nanosecond;
#endif
        default:
            [NSException raise:NSInvalidArgumentException format:@"unit %lu is invalid", (unsigned long)unit];
            break;
    }
    
    return 0;
}

+ (NSDateComponents *)components:(NSCalendarUnit)unit fromTimeInterval:(NSTimeInterval)interval {
    NSDate *start = [NSDate date];
    NSDate *end = [start dateByAddingTimeInterval:interval];
    return [[NSCalendar autoupdatingCurrentCalendar] components:unit fromDate:start toDate:end options:0];
}

// Helper to get the suitable unit string
- (NSString *)stringForComponent:(NSCalendarUnit)unit count:(NSInteger)count {
    if (count == 0)
        return nil;
    
    NSString *key = nil;
    switch (unit) {
        case NSCalendarUnitYear:
            key = @"year";
            break;
        case NSMonthCalendarUnit:
            key = @"month";
            break;
        case NSWeekCalendarUnit:
            key = @"week";
            break;
        case NSDayCalendarUnit:
            key = @"day";
            break;
        case NSHourCalendarUnit:
            key = @"hour";
            break;
        case NSMinuteCalendarUnit:
            key = @"minute";
            break;
        case NSSecondCalendarUnit:
            key = @"second";
            break;
        default:
            break;
    }
    
    NSString *testKey = [NSString stringWithFormat:@"%@##%lu", key, labs(count)];
    NSString *value = NSDateComponentsHNExtensionsString(testKey, nil);
    
    // Different plural forms
    if (labs(count) > 1) {
        // Ending in...
        if ([value isEqualToString:testKey]) {
            NSUInteger lastDigit = labs(count % 10);
            testKey = [NSString stringWithFormat:@"%@##x%lu", key, (unsigned long)lastDigit];
            value = NSDateComponentsHNExtensionsString(testKey, nil);
        }
        
        // Plural if > 1
        if ([value isEqualToString:testKey]) {
            testKey = [NSString stringWithFormat:@"%@##plural", key];
            value = NSDateComponentsHNExtensionsString(testKey, nil);
        }
    }
    
    // Singular
    if ([value isEqualToString:testKey]) {
        value = NSDateComponentsHNExtensionsString(key, nil);
    }
    
    return [NSString stringWithFormat:@"%li %@", (long)count, value];
}

- (NSString *)localizedStringFromUnit:(NSCalendarUnit)fromUnit toUnit:(NSCalendarUnit)toUnit {
    toUnit = MIN(NSCalendarUnitSecond, MAX(NSCalendarUnitYear, toUnit));
    fromUnit = MAX(NSCalendarUnitYear, MIN(toUnit, fromUnit));
    
    NSMutableArray *components = [NSMutableArray array];
    NSCalendarUnit unit = fromUnit;
    while (unit <= toUnit) {
        NSString *component = [self stringForComponent:unit count:[self hnextensions_valueForComponent:unit]];
        if ([component length] > 0)
            [components addObject:component];
        
        unit = (unit << 1);
    }
    
    return [components componentsJoinedByString:@" "];
}

@end
