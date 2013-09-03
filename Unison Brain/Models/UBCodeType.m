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
    NSMutableArray *types = [[NSMutableArray alloc]init];
    
    for (UBCodeType *type in [self all]) {
        if ([type.name isEqualToString:@"Social Process"])[types addObject:type];
        else if ([type.name isEqualToString:@"Decoding"])[types addObject:type];
        else if ([type.name isEqualToString:@"Genre"])[types addObject:type];
        else if ([type.name isEqualToString:@"Comprehension"])[types addObject:type];
    }
    
    return types;

}

@end
