//
//  UBModel.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface UBModel : NSManagedObject

@property (nonatomic, retain) NSNumber *updatedAt;

+ (UBModel *)find:(NSString *)modelId;
+ (UBModel *)create;
+ (NSArray *)all;

+ (void)fetchAll;

+ (NSString *)modelName;
+ (NSString *)modelUrl;
+ (NSArray *)modelSort;
+ (NSDictionary *)keyMap;

- (void)save;
- (void)destroy;
- (void)sync;

@end
