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
+ (NSString *)modelName
{
    NSLog(@"Error: 'modelName' method not implemented");
    abort();
}

+ (NSString *)modelUrl
{
    NSLog(@"Error: 'modelUrl' method not implemented");
    abort();
}

+ (NSArray *)modelSort
{
    return nil;
}

+ (id)create
{
    return [NSEntityDescription insertNewObjectForEntityForName:[self modelName] inManagedObjectContext:[UBAppDelegate moc]];
}

+ (NSArray *)all
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:[self modelName] inManagedObjectContext:[UBAppDelegate moc]];
    
    fetchRequest.entity = entity;
    fetchRequest.fetchBatchSize = 40;
    
    [fetchRequest setSortDescriptors:[self modelSort]];
    
    NSError *error = nil;
    NSArray *results = [[UBAppDelegate moc] executeFetchRequest:fetchRequest error:&error];
    
    if (results == nil) {
        NSLog(@"Error %@: Fetch request failed", [self modelName]);
        abort();
    }
    
    return results;
}

@end
