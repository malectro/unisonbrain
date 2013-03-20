//
//  UBContribution.m
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBContribution.h"
#import "UBBreach.h"
#import "UBPerson.h"

#import "UBDate.h"

@implementation UBContribution

@dynamic text;
@dynamic time;
@dynamic breach;
@dynamic person;

+ (NSString *)modelName
{
    return @"UBContribution";
}

+ (NSDictionary *)keyMap
{
    return @{@"time": @"time",
             @"text": @"text",
             @"breach": [UBBreach class],
             @"person": [UBPerson class]};
}

- (NSDictionary *)asDict
{
    NSMutableDictionary *dict = [[self dictionaryWithValuesForKeys:@[@"text", @"id"]] mutableCopy];
    
    dict[@"time"] = [UBDate toNum:self.time];
    
    // this should never happen, but our early data can create teachers with nil ids
    if (self.person.id) {
        dict[@"person_id"] = self.person.id;
    }
    
    return dict;
}

- (void)save
{
    NSLog(@"Breaches are meant to be embedded in sessions. Do not invoke save on a breach.");
    abort();
}

@end
