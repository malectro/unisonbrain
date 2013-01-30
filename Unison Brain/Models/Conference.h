//
//  Conference.h
//  Unison Brain
//
//  Created by Amy Piller on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Conference : NSManagedObject

@property (nonatomic, retain) NSNumber * isComplete;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSSet *codeScores;
@property (nonatomic, retain) NSManagedObject *student;
@property (nonatomic, retain) NSManagedObject *subject;
@property (nonatomic, retain) NSManagedObject *teacher;
@end

@interface Conference (CoreDataGeneratedAccessors)

- (void)addCodeScoresObject:(NSManagedObject *)value;
- (void)removeCodeScoresObject:(NSManagedObject *)value;
- (void)addCodeScores:(NSSet *)values;
- (void)removeCodeScores:(NSSet *)values;

@end
