//
//  UBFunctions.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/5/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBFunctions.h"

CGRect CGRectPosition(CGRect rect, CGFloat x, CGFloat y)
{
    return CGRectMake(x, y, rect.size.width, rect.size.height);
}

CGRect CGRectSize(CGRect rect, CGFloat width, CGFloat height)
{
    return CGRectMake(rect.origin.x, rect.origin.y, width, height);
}

NSArray * NSArrayFill(id filler, NSInteger count)
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];
    
    while (count > 0) {
        [array addObject:filler];
    }
    
    return array;
}

@implementation UBFunctions

@end
