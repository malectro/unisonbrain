//
//  UBUser.m
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBUser.h"

#import "UBAppDelegate.h"

@implementation UBUser

#pragma mark - class methods

static UBUser *currentUser;

+ (UBUser *)currentUser
{
    if (currentUser == nil) {
        // test stuff that shouldn't be used
       UBTeacher *teacher = [UBTeacher all][0];
        //UBTeacher *teacher = [UBTeacher create];
        //teacher.fname = @"Kyle";
        //teacher.lname = @"Warren";
        
        currentUser = [[UBUser alloc] initWithTeacher:teacher];
        
    }
    
    return currentUser;
}

#pragma mark - instance methods

@synthesize teacher = _teacher;

- (id)initWithTeacher:(UBTeacher *)teacher
{
    self = [super init];
    if (self) {
        _teacher = teacher;
    }
    return self;
}

@end
