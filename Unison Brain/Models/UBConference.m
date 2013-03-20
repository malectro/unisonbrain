//
//  UBConference.m
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBConference.h"
#import "UBCodeScore.h"
#import "UBStudent.h"
#import "UBSubject.h"
#import "UBTeacher.h"


@implementation UBConference

@dynamic isComplete;
@dynamic notes;
@dynamic time;
@dynamic codeScores;
@dynamic student;
@dynamic subject;
@dynamic teacher;

+ (NSString *)modelName
{
    return @"UBConference";
}

+ (NSString *)modelUrl
{
    return @"conferences";
}

+ (id)create
{
    UBConference *conf = [super create];

    conf.time = [NSDate date];
    conf.notes = @"";
    
    return conf;
}

+ (NSDictionary *)keyMap
{
    return @{@"is_complete": @"isComplete",
             @"notes": @"notes",
             @"time": @"time",
             @"codeScores": [UBCodeScore class],
             @"student": [UBStudent class],
             @"teacher": [UBTeacher class],
             @"subject": [UBSubject class]};
}

- (NSDictionary *)asDict
{
    NSMutableDictionary *dict = [[self dictionaryWithValuesForKeys:@[@"id", @"isComplete", @"notes", @"time"]] mutableCopy];
    
    dict[@"is_complete"] = dict[@"isComplete"];
    [dict removeObjectForKey:@"isComplete"];
    
    if (self.student) {
        dict[@"student_id"] = self.student.id;
    }
    
    if (self.teacher) {
        dict[@"teacher_id"] = self.teacher.id;
    }
    
    if (self.subject) {
        dict[@"subject_id"] = self.subject.id;
    }
    
    dict[@"code_scores"] = [self.codeScores.allObjects valueForKey:@"asDict"];
    
    dict[@"time"] = [NSNumber numberWithInteger:[dict[@"time"] timeIntervalSince1970]];
    
    return dict;
}

@end
