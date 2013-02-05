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

@end
