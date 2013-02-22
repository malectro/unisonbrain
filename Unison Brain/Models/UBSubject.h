//
//  UBSubject.h
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "UBModel.h"

@class UBConference, UBSession;

@interface UBSubject : UBModel

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *conferences;
@property (nonatomic, retain) NSSet *codes;
@property (nonatomic, retain) NSSet *sessions;
@property (nonatomic) NSArray *sortedCodes;

@end

@interface UBSubject (CoreDataGeneratedAccessors)

- (void)addConferencesObject:(UBConference *)value;
- (void)removeConferencesObject:(UBConference *)value;
- (void)addConferences:(NSSet *)values;
- (void)removeConferences:(NSSet *)values;

- (void)addSessionsObject:(UBSession *)value;
- (void)removeSessionsObject:(UBSession *)value;
- (void)addSessions:(NSSet *)values;
- (void)removeSessions:(NSSet *)values;

@end
