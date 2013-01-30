//
//  Breach.h
//  Unison Brain
//
//  Created by Amy Piller on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Code, Contribution, Person, Session;

@interface Breach : NSManagedObject

@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSSet *codes;
@property (nonatomic, retain) NSSet *contributions;
@property (nonatomic, retain) NSSet *people;
@property (nonatomic, retain) Session *session;
@end

@interface Breach (CoreDataGeneratedAccessors)

- (void)addCodesObject:(Code *)value;
- (void)removeCodesObject:(Code *)value;
- (void)addCodes:(NSSet *)values;
- (void)removeCodes:(NSSet *)values;

- (void)addContributionsObject:(Contribution *)value;
- (void)removeContributionsObject:(Contribution *)value;
- (void)addContributions:(NSSet *)values;
- (void)removeContributions:(NSSet *)values;

- (void)addPeopleObject:(Person *)value;
- (void)removePeopleObject:(Person *)value;
- (void)addPeople:(NSSet *)values;
- (void)removePeople:(NSSet *)values;

@end
