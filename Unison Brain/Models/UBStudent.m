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
#import "UBCodeScore.h"


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

- (void)fetchConferences
{
    [UBConference fetchUrl:[NSString stringWithFormat:@"students/%@/conferences", self.id]];
}

- (void)fetchCodeScores
{
    [UBCodeScore fetchUrl:[NSString stringWithFormat:@"students/%@/code_scores", self.id]];
}

@end
