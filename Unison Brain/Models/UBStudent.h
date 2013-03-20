//
//  UBStudent.h
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UBPerson.h"

@class UBConference;

@interface UBStudent : UBPerson

@property (nonatomic, retain) NSString * section;
@property (nonatomic, retain) NSSet *conferences;

- (void)fetchSessions;

@end

@interface UBStudent (CoreDataGeneratedAccessors)

- (void)addConferencesObject:(UBConference *)value;
- (void)removeConferencesObject:(UBConference *)value;
- (void)addConferences:(NSSet *)values;
- (void)removeConferences:(NSSet *)values;

@end
