//
//  UBTeacher.m
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBTeacher.h"
#import "UBConference.h"
#import "UBSession.h"
#import "UBStudent.h"


@implementation UBTeacher

@dynamic conferences;
@dynamic students;

+ (NSString *)modelName
{
    return @"UBTeacher";
}

+ (NSString *)modelUrl
{
    return @"teachers";
}

+ (NSDictionary *)keyMap
{
    return @{@"fname": @"fname",
             @"lname": @"lname",
             @"school": @"school",
             @"students": [UBStudent class]};
}

- (void)fetchSessions
{
    [UBSession fetchUrl:[NSString stringWithFormat:@"teachers/%@/sessions", self.id]];
}

- (void)fetchConferences
{
    [UBConference fetchUrl:[NSString stringWithFormat:@"students/%@/conferences", self.id]];
}

@end
