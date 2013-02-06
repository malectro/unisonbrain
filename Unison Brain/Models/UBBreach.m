//
//  UBBreach.m
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBBreach.h"
#import "UBCode.h"
#import "UBContribution.h"
#import "UBPerson.h"
#import "UBSession.h"


@implementation UBBreach

@dynamic time;
@dynamic type;
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

- (NSString *)studentList
{
    return [((NSSet *)[self.people valueForKey:@"fname"]).allObjects componentsJoinedByString:@", "];
}

- (NSArray *)sortedContributions
{
    if (_sortedContributions == nil) {
        NSSortDescriptor *descriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES];
        _sortedContributions = [self.contributions sortedArrayUsingDescriptors:@[descriptor1]];
    }
    
    return _sortedContributions;
}

@end
