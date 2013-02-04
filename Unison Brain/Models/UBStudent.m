//
//  UBStudent.m
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBStudent.h"
#import "UBConference.h"


@implementation UBStudent

@dynamic section;
@dynamic conferences;

+ (NSString *)modelName
{
    return @"UBStudent";
}

@end
