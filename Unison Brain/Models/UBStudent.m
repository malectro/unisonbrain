//
//  UBStudent.m
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBStudent.h"
#import "UBConference.h"
#import "UBSession.h"


@implementation UBStudent

@dynamic section;
@dynamic conferences;

+ (NSString *)modelName
{
    return @"UBStudent";
}

+ (NSString *)modelUrl
{
    return @"students";
}

+ (NSDictionary *)keyMap
{
    return @{@"fname": @"fname",
             @"lname": @"lname",
             @"school": @"school",
             @"section": @"section"};
}

- (void)fetchSessions
{
    [UBSession fetchUrl:[NSString stringWithFormat:@"students/%@/sessions", self.id]];
}

@end
