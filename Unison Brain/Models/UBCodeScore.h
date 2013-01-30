//
//  UBCodeScore.h
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UBCode, UBConference;

@interface UBCodeScore : NSManagedObject

@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) UBCode *code;
@property (nonatomic, retain) NSSet *conferences;
@end

@interface UBCodeScore (CoreDataGeneratedAccessors)

- (void)addConferencesObject:(UBConference *)value;
- (void)removeConferencesObject:(UBConference *)value;
- (void)addConferences:(NSSet *)values;
- (void)removeConferences:(NSSet *)values;

@end
