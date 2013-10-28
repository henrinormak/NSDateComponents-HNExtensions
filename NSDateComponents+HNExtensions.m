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

@implementation NSDateComponents (HNExtensions)

#if !(TARGET_OS_MAC && !(TARGET_OS_EMBEDDED || TARGET_OS_IPHONE)) && !NS_ENABLE_CALENDAR_NEW_API

- (void)setValue:(NSInteger)value forComponent:(NSCalendarUnit)unit {
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
            [NSException raise:NSInvalidArgumentException format:@"unit %i is invalid", unit];
            break;
    }
}

- (NSInteger)valueForComponent:(NSCalendarUnit)unit {
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
            [NSException raise:NSInvalidArgumentException format:@"unit %i is invalid", unit];
            break;
    }
    
    return 0;
}

#endif

- (NSString *)localizedFormattedString {
    return nil;
}

@end