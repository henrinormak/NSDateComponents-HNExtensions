//
//  NSDateComponents+HNExtensions.h
//
//  A few handy shortcuts for NSDateComponents
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

#import <Foundation/Foundation.h>
#define NSDateComponentsHNExtensionsStringsTable @"NSDateComponents+HNExtensions"

@interface NSDateComponents (HNExtensions)

// Use the same condition (negated) as NSDateComponents itself uses to enable these methods, this is to avoid a duplicate definition
#if !(TARGET_OS_MAC && !(TARGET_OS_EMBEDDED || TARGET_OS_IPHONE)) && !NS_ENABLE_CALENDAR_NEW_API

// The calendar and timeZone units are not valid for these methods.
- (void)setValue:(NSInteger)value forComponent:(NSCalendarUnit)unit;
- (NSInteger)valueForComponent:(NSCalendarUnit)unit;

#endif

// Creating date components from a time interval
// Uses system calendar (i.e NSCalendar -autoupdatingCurrentCalendar)
+ (NSDateComponents *)components:(NSCalendarUnit)unit fromTimeInterval:(NSTimeInterval)interval NS_AVAILABLE(10_5, 2_0);;


// Returns a string localized to the format of "x hours x minutes"
// Upper bound (from) is bound to year, lower bound (to) is bound to second
// fromUnit <= toUnit must be true, will be enforced by raising fromUnit
// Uses strings from the table specified by NSDateComponentsHNExtensionsStringsTable
- (NSString *)localizedStringFromUnit:(NSCalendarUnit)fromUnit toUnit:(NSCalendarUnit)toUnit;

@end
