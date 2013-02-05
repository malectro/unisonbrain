//
//  UBSession.m
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBSession.h"
#import "UBBreach.h"
#import "UBPerson.h"
#import "UBStudent.h"
#import "UBSubject.h"


@implementation UBSession

@dynamic isCoded;
@dynamic isComplete;
@dynamic length;
@dynamic order;
@dynamic time;
@dynamic breaches;
@dynamic people;
@dynamic subject;

+ (NSString *)modelName
{
    return @"UBSession";
}

- (NSSet *)students
{
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return [((UBPerson *)evaluatedObject) isKindOfClass:[UBStudent class]];
    }];
    return [self.people filteredSetUsingPredicate:predicate];
}

- (NSSet *)teachers
{
    NSMutableSet *tempSet = [NSMutableSet setWithSet:self.people];
    [tempSet minusSet:self.students];
    return tempSet;
}

- (NSArray *)sortedBreaches
{
    NSSortDescriptor *descriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES];
    return [self.breaches sortedArrayUsingDescriptors:@[descriptor1]];
}

@end
