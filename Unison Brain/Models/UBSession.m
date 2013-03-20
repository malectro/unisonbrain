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

+ (NSString *)modelUrl
{
    return @"sessions";
}

+ (UBSession *)create
{
    UBSession *session = [super create];
    
    session.time = [NSDate date];
    session.isCoded = NO;
    session.isComplete = NO;
    
    return session;
}

+ (NSDictionary *)keyMap
{
    return @{@"is_coded": @"isCoded",
             @"is_complete": @"isComplete",
             @"length": @"length",
             @"order": @"order",
             @"time": @"time",
             @"breaches": [UBBreach class],
             @"people": [UBPerson class],
             @"subject": [UBSubject class]};
}

- (NSDictionary *)asDict
{
    NSMutableDictionary *dict = [[self dictionaryWithValuesForKeys:@[@"id", @"isCoded", @"isComplete", @"length", @"order", @"time"]] mutableCopy];
    
    dict[@"is_coded"] = dict[@"isCoded"];
    [dict removeObjectForKey:@"isCoded"];
    dict[@"is_complete"] = dict[@"isComplete"];
    [dict removeObjectForKey:@"isComplete"];
    
    dict[@"person_ids"] = [self.people.allObjects valueForKey:@"id"];
    
    if (self.subject) {
        dict[@"subject_id"] = self.subject.id;
    }
    
    dict[@"breaches"] = [self.breaches.allObjects valueForKey:@"asDict"];
    
    dict[@"time"] = [NSNumber numberWithInteger:[dict[@"time"] timeIntervalSince1970]];
    
    return dict;
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

- (NSString *)studentList
{
    return [((NSSet *)[self.students valueForKey:@"fname"]).allObjects componentsJoinedByString:@", "];
}

- (void)fetchBreaches
{
    [UBBreach fetchUrl:[NSString stringWithFormat:@"sessions/%@/breaches", self.id]];
}

@end
