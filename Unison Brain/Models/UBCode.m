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


@implementation UBCode

@dynamic name;
@dynamic type;
@dynamic year;
@dynamic breaches;
@dynamic codeScores;

+ (NSString *)modelName
{
    return @"UBCode";
}

@end
