//
//  UBPerson.h
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "UBModel.h"

@class UBBreach, UBContribution, UBSession;

@interface UBPerson : UBModel

@property (nonatomic, retain) NSString * fname;
@property (nonatomic, retain) NSString * lname;
@property (nonatomic, retain) NSString * school;
@property (nonatomic, retain) NSSet *breaches;
@property (nonatomic, retain) NSSet *contributions;
@property (nonatomic, retain) NSSet *sessions;

@property (nonatomic, readonly) NSString *name;

@end

@interface UBPerson (CoreDataGeneratedAccessors)

- (void)addBreachesObject:(UBBreach *)value;
- (void)removeBreachesObject:(UBBreach *)value;
- (void)addBreaches:(NSSet *)values;
- (void)removeBreaches:(NSSet *)values;

- (void)addContributionsObject:(UBContribution *)value;
- (void)removeContributionsObject:(UBContribution *)value;
- (void)addContributions:(NSSet *)values;
- (void)removeContributions:(NSSet *)values;

- (void)addSessionsObject:(UBSession *)value;
- (void)removeSessionsObject:(UBSession *)value;
- (void)addSessions:(NSSet *)values;
- (void)removeSessions:(NSSet *)values;

@end
