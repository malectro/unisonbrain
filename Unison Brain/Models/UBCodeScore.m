//
//  UBCodeScore.m
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBCodeScore.h"
#import "UBCode.h"
#import "UBConference.h"
#import "UBAppDelegate.h"



@implementation UBCodeScore

@dynamic comment;
@dynamic score;
@dynamic notion;
@dynamic code;
@dynamic conference;

+ (NSString *)modelName
{
    return @"UBCodeScore";
}

+ (NSDictionary *)keyMap
{
    return @{@"comment": @"comment",
             @"score": @"score",
             @"notion": @"notion",
             @"code": [UBCode class],
             @"conference": [UBConference class]};
}

NSArray *notions;
+ (NSArray *)notions
{
    if (notions == nil) {
        notions = @[@"strength", @"weakness", @"goal"];
    }
    return notions;
}

- (NSDictionary *)asDict
{
    NSMutableDictionary *dict = [[self dictionaryWithValuesForKeys:@[@"comment", @"id", @"score", @"notion"]] mutableCopy];
    
    if (self.code) {
        dict[@"code_id"] = self.code.id;
    }
    
    return dict;
}


- (void)save
{
    NSLog(@"CodeScores are meant to be embedded in conferences. Do not invoke save on a CodeScore.");
    abort();
}

@end
