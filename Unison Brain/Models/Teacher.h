//
//  Teacher.h
//  Unison Brain
//
//  Created by Amy Piller on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Person.h"

@class Conference;

@interface Teacher : Person

@property (nonatomic, retain) NSSet *conferences;
@end

@interface Teacher (CoreDataGeneratedAccessors)

- (void)addConferencesObject:(Conference *)value;
- (void)removeConferencesObject:(Conference *)value;
- (void)addConferences:(NSSet *)values;
- (void)removeConferences:(NSSet *)values;

@end
