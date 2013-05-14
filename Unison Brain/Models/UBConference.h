//
//  UBConference.h
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "UBModel.h"

@class UBCodeScore, UBStudent, UBSubject, UBTeacher;

@interface UBConference : UBModel

@property (nonatomic, retain) NSNumber * isComplete;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSSet *codeScores;
@property (nonatomic, retain) UBStudent *student;
@property (nonatomic, retain) UBSubject *subject;
@property (nonatomic, retain) UBTeacher *teacher;

@property (nonatomic) BOOL complete;

@end

@interface UBConference (CoreDataGeneratedAccessors)

- (void)addCodeScoresObject:(UBCodeScore *)value;
- (void)removeCodeScoresObject:(UBCodeScore *)value;
- (void)addCodeScores:(NSSet *)values;
- (void)removeCodeScores:(NSSet *)values;

@end
