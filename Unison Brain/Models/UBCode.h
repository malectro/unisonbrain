//
//  UBCode.h
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UBBreach, UBCodeScore;

@interface UBCode : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSSet *breaches;
@property (nonatomic, retain) NSSet *codeScores;
@end

@interface UBCode (CoreDataGeneratedAccessors)

- (void)addBreachesObject:(UBBreach *)value;
- (void)removeBreachesObject:(UBBreach *)value;
- (void)addBreaches:(NSSet *)values;
- (void)removeBreaches:(NSSet *)values;

- (void)addCodeScoresObject:(UBCodeScore *)value;
- (void)removeCodeScoresObject:(UBCodeScore *)value;
- (void)addCodeScores:(NSSet *)values;
- (void)removeCodeScores:(NSSet *)values;

@end
