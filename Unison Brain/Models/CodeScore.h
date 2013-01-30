//
//  CodeScore.h
//  Unison Brain
//
//  Created by Amy Piller on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Code, Conference;

@interface CodeScore : NSManagedObject

@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) Code *code;
@property (nonatomic, retain) NSSet *conferences;
@end

@interface CodeScore (CoreDataGeneratedAccessors)

- (void)addConferencesObject:(Conference *)value;
- (void)removeConferencesObject:(Conference *)value;
- (void)addConferences:(NSSet *)values;
- (void)removeConferences:(NSSet *)values;

@end
