//
//  UBDate.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/5/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UBDate : NSObject

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;
+ (NSString *)stringFromDateMedium:(NSDate *)date;
+ (NSString *)stringFromDateShort:(NSDate *)date;

+ (NSNumber *)toNum:(NSDate *)time;

@end
