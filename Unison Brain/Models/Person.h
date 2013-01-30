//
//  Person.h
//  Unison Brain
//
//  Created by Amy Piller on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Breach, Session;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * fname;
@property (nonatomic, retain) NSString * lname;
@property (nonatomic, retain) NSString * school;
@property (nonatomic, retain) NSSet *breaches;
@property (nonatomic, retain) NSSet *contributions;
@property (nonatomic, retain) NSSet *sessions;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addBreachesObject:(Breach *)value;
- (void)removeBreachesObject:(Breach *)value;
- (void)addBreaches:(NSSet *)values;
- (void)removeBreaches:(NSSet *)values;

- (void)addContributionsObject:(NSManagedObject *)value;
- (void)removeContributionsObject:(NSManagedObject *)value;
- (void)addContributions:(NSSet *)values;
- (void)removeContributions:(NSSet *)values;

- (void)addSessionsObject:(Session *)value;
- (void)removeSessionsObject:(Session *)value;
- (void)addSessions:(NSSet *)values;
- (void)removeSessions:(NSSet *)values;

@end
