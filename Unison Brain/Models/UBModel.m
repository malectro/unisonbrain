//
//  UBModel.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBModel.h"
#import "UBAppDelegate.h"
#import "UBRequest.h"

@implementation UBModel

@dynamic updatedAt;

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

+ (NSDictionary *)keyMap
{
    return @{@"updated_at": @"updatedAt",
             @"_id": @"id"};
}

+ (NSFetchRequest *)modelRequest
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:[self modelName] inManagedObjectContext:[UBAppDelegate moc]];
    
    fetchRequest.entity = entity;
    
    return fetchRequest;
}

+ (NSArray *)modelResults:(NSFetchRequest *)fetchRequest
{
    NSError *error = nil;
    NSArray *results = [[UBAppDelegate moc] executeFetchRequest:fetchRequest error:&error];
    
    if (results == nil) {
        NSLog(@"Error %@: Fetch request failed", [self modelName]);
        abort();
    }
    
    return results;
}

+ (UBModel *)find:(NSString *)modelId
{
    NSFetchRequest *fetchRequest = [self modelRequest];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id == %@", modelId];
    
    fetchRequest.predicate = predicate;
    
    NSArray *results = [self modelResults:fetchRequest];
    UBModel *returnal = nil;
    
    if (results.count > 0) {
        returnal = results[0];
    }
    
    return returnal;
}

+ (UBModel *)create
{
    return [NSEntityDescription insertNewObjectForEntityForName:[self modelName] inManagedObjectContext:[UBAppDelegate moc]];
}

+ (NSArray *)all
{
    NSFetchRequest *fetchRequest = [self modelRequest];
    
    fetchRequest.fetchBatchSize = 40;
    [fetchRequest setSortDescriptors:[self modelSort]];
    
    return [self modelResults:fetchRequest];
}

+ (void)fetchAll
{
    [UBRequest get:[self modelUrl] callback:^(NSArray *models) {
        UBModel *model = nil;
        
        for (NSDictionary *dict in models) {
            model = [self find:dict[@"_id"]];
            
            if (model == nil) {
                model = [self create];
            }
            
            if (model.updatedAt.intValue < (NSInteger) dict[@"updated_at"]) {
                [model updateWithDict:dict];
            }
        }
        
        [model save];
    }];
}

- (void)updateWithDict:(NSDictionary *)dict
{
    NSMutableDictionary *keyMap = [NSMutableDictionary dictionaryWithDictionary:[[self class] keyMap]];
    
    keyMap[@"updated_at"] = @"updatedAt";
    keyMap[@"_id"] = @"id";
    
    for (NSString *key in dict) {
        if (keyMap[key]) {
            if (dict[key] != [NSNull null]) {
                [self setValue:dict[key] forKey:keyMap[key]];
            }
        }
    }
}

- (void)save
{
    NSError *error = nil;
    if (![[UBAppDelegate moc] save:&error]) {
        NSLog(@"Error %@: Failed to save managed object context", [[self class] modelName]);
        abort();
    }
}

- (void)destroy
{
    // kill self
    [[UBAppDelegate moc] deleteObject:self];
    [self save];
}
    
- (void)sync
{

    
}

@end
