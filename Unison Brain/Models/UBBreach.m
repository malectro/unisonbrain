//
//  UBBreach.m
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBBreach.h"
#import "UBCode.h"
#import "UBCodeType.h"
#import "UBContribution.h"
#import "UBPerson.h"
#import "UBSession.h"

#import "UBDate.h"


@implementation UBBreach

@dynamic time;
@dynamic codeType;
@dynamic codes;
@dynamic contributions;
@dynamic people;
@dynamic session;

@synthesize sortedContributions = _sortedContributions;

+ (NSString *)modelName
{
    return @"UBBreach";
}

+ (UBBreach *)create
{
    UBBreach *breach = [super create];
    breach.time = [NSDate date];
    return breach;
}

+ (NSDictionary *)keyMap
{
    return @{@"time": @"time",
             @"contributions": [UBContribution class],
             @"codeType": [UBCodeType class],
             @"people": [UBPerson class],
             @"codes": [UBCode class],
             @"session": [UBSession class]};
}

- (NSDictionary *)asDict
{
    NSMutableDictionary *dict = [[self dictionaryWithValuesForKeys:@[@"time", @"id"]] mutableCopy];
    
    dict[@"time"] = [UBDate toNum:self.time];
    
    dict[@"code_type_id"] = self.codeType.id;
    dict[@"code_ids"] = [self.codes.allObjects valueForKey:@"id"];
    
    dict[@"contributions"] = [self.contributions.allObjects valueForKey:@"asDict"];
    
    dict[@"person_ids"] = [self.people.allObjects valueForKey:@"id"];
    
    return dict;
}

- (NSString *)studentList
{
    return [((NSSet *)[self.people valueForKey:@"fname"]).allObjects componentsJoinedByString:@", "];
}

- (NSString *)codeList
{
    return [((NSSet *)[self.codes valueForKey:@"name"]).allObjects componentsJoinedByString:@", "];
}

- (NSArray *)sortedContributions
{
    if (_sortedContributions == nil) {
        NSSortDescriptor *descriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES];
        _sortedContributions = [self.contributions sortedArrayUsingDescriptors:@[descriptor1]];
    }
    
    return _sortedContributions;
}

- (void)save
{
    NSLog(@"Breaches are meant to be embedded in sessions. Do not invoke save on a breach.");
    abort();
}

@end
