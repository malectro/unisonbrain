//
//  Code.h
//  Unison Brain
//
//  Created by Amy Piller on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Breach;

@interface Code : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSSet *breaches;
@property (nonatomic, retain) NSSet *codeScores;
@end

@interface Code (CoreDataGeneratedAccessors)

- (void)addBreachesObject:(Breach *)value;
- (void)removeBreachesObject:(Breach *)value;
- (void)addBreaches:(NSSet *)values;
- (void)removeBreaches:(NSSet *)values;

- (void)addCodeScoresObject:(NSManagedObject *)value;
- (void)removeCodeScoresObject:(NSManagedObject *)value;
- (void)addCodeScores:(NSSet *)values;
- (void)removeCodeScores:(NSSet *)values;

@end
