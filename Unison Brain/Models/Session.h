//
//  Session.h
//  Unison Brain
//
//  Created by Amy Piller on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Breach;

@interface Session : NSManagedObject

@property (nonatomic, retain) NSNumber * isCoded;
@property (nonatomic, retain) NSNumber * isComplete;
@property (nonatomic, retain) NSNumber * length;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSSet *breaches;
@property (nonatomic, retain) NSSet *people;
@property (nonatomic, retain) NSManagedObject *subject;
@end

@interface Session (CoreDataGeneratedAccessors)

- (void)addBreachesObject:(Breach *)value;
- (void)removeBreachesObject:(Breach *)value;
- (void)addBreaches:(NSSet *)values;
- (void)removeBreaches:(NSSet *)values;

- (void)addPeopleObject:(NSManagedObject *)value;
- (void)removePeopleObject:(NSManagedObject *)value;
- (void)addPeople:(NSSet *)values;
- (void)removePeople:(NSSet *)values;

@end
