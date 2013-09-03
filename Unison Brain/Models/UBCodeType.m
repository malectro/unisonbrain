//
//  UBType.m
//  Unison Brain
//
//  Created by Amy Piller on 2/10/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBCodeType.h"

#import "UBCode.h"


@implementation UBCodeType

@dynamic name;
@dynamic codes;

+ (NSString *)modelName
{
    return @"UBCodeType";
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

+ (NSArray *)urBreachTypes
{
   // RETURN array of codeTypes in subject Unison
    return [self all];

}

@end
