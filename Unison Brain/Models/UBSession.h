//
//  UBSession.h
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "UBModel.h"

@class UBBreach, UBPerson, UBSubject;

@interface UBSession : UBModel

@property (nonatomic, retain) NSNumber * isCoded;
@property (nonatomic, retain) NSNumber * isComplete;
@property (nonatomic, retain) NSNumber * length;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSSet *breaches;
@property (nonatomic, retain) NSSet *people;
@property (nonatomic, retain) UBSubject *subject;
@end

@interface UBSession (CoreDataGeneratedAccessors)

- (void)addBreachesObject:(UBBreach *)value;
- (void)removeBreachesObject:(UBBreach *)value;
- (void)addBreaches:(NSSet *)values;
- (void)removeBreaches:(NSSet *)values;

- (void)addPeopleObject:(UBPerson *)value;
- (void)removePeopleObject:(UBPerson *)value;
- (void)addPeople:(NSSet *)values;
- (void)removePeople:(NSSet *)values;

@end
