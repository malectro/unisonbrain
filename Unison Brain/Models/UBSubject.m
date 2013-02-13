//
//  UBSubject.m
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBSubject.h"
#import "UBConference.h"
#import "UBSession.h"


@implementation UBSubject

@dynamic name;
@dynamic conferences;
@dynamic sessions;
@dynamic codes;

+ (NSString *)modelName
{
    return @"UBSubject";
}

+ (NSString *)modelUrl
{
    return @"subjects";
}

+ (NSDictionary *)keyMap
{
    return @{@"name": @"name"};
}

@end
