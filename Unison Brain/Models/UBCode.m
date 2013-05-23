//
//  UBCode.m
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBCode.h"
#import "UBBreach.h"
#import "UBCodeScore.h"
#import "UBCodeType.h"


@implementation UBCode

@dynamic name;
@dynamic text;
@dynamic codeType;
@dynamic subject;
@dynamic year;
@dynamic breaches;
@dynamic codeScores;

+ (NSString *)modelName
{
    return @"UBCode";
}

+ (NSString *)modelUrl
{
    return @"codes";
}

+ (NSDictionary *)keyMap
{
    return @{@"name": @"name",
             @"year": @"year",
             @"text": @"text",
             @"subject": [UBSubject class]};
}

@end
