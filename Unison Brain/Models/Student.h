//
//  Student.h
//  Unison Brain
//
//  Created by Amy Piller on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Person.h"

@class Conference;

@interface Student : Person

@property (nonatomic, retain) NSString * section;
@property (nonatomic, retain) NSSet *conferences;
@end

@interface Student (CoreDataGeneratedAccessors)

- (void)addConferencesObject:(Conference *)value;
- (void)removeConferencesObject:(Conference *)value;
- (void)addConferences:(NSSet *)values;
- (void)removeConferences:(NSSet *)values;

@end
