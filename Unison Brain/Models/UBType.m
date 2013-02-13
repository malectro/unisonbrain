//
//  UBType.m
//  Unison Brain
//
//  Created by Amy Piller on 2/10/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBType.h"

#import "UBCode.h"

@implementation UBType

@dynamic name;
@dynamic codes;

+ (NSString *)modelName
{
    return @"UBType";
}

+ (NSString *)modelUrl
{
    return @"code_types";
}

+ (NSDictionary *)keyMap
{
    return @{@"name": @"name",
             @"codes": [UBCode class]};
}

@end
