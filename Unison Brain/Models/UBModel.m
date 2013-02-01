//
//  UBModel.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBModel.h"
#import "UBAppDelegate.h"

@implementation UBModel

// Override these method
+ (NSString *)name
{
    NSLog(@"Error: 'name' method not implemented");
    abort();
}

+ (NSString *)url
{
    NSLog(@"Error: 'url' method not implemented");
    abort();
}



+ (id)create
{
    return [NSEntityDescription insertNewObjectForEntityForName:[self name] inManagedObjectContext:[UBAppDelegate moc]];
}

@end
