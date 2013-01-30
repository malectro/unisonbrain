//
//  Subject.h
//  Unison Brain
//
//  Created by Amy Piller on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Conference, Session;

@interface Subject : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *conferences;
@property (nonatomic, retain) NSSet *sessions;
@end

@interface Subject (CoreDataGeneratedAccessors)

- (void)addConferencesObject:(Conference *)value;
- (void)removeConferencesObject:(Conference *)value;
- (void)addConferences:(NSSet *)values;
- (void)removeConferences:(NSSet *)values;

- (void)addSessionsObject:(Session *)value;
- (void)removeSessionsObject:(Session *)value;
- (void)addSessions:(NSSet *)values;
- (void)removeSessions:(NSSet *)values;

@end
