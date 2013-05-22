//
//  UBColor.m
//  Unison Brain
//
//  Created by Kyle Warren on 5/22/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBColor.h"

@implementation UBColor

+ (UIColor *)r:(CGFloat)r g:(CGFloat)g b:(CGFloat)b
{
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
}

+ (UIColor *)borderColor
{
    return [self r:0.8f g:0.8f b:0.8f];
}

@end
