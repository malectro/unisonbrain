//
//  UBUser.m
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBUser.h"

#import "UBTeacher.h"

#import "UBRequest.h"
#import "UBAppDelegate.h"

@implementation UBUser

#pragma mark - class methods

static UBUser *currentUser;

+ (UBUser *)currentUser
{
    if (currentUser == nil) {
        currentUser = [[UBUser alloc] initWithTeacher:nil];
    }
    
    return currentUser;
}

#pragma mark - instance methods

@synthesize teacher = _teacher;

- (id)initWithTeacher:(UBTeacher *)teacher
{
    self = [super init];
    if (self) {
        if (teacher == nil) {
            NSString *userId = [[NSUserDefaults standardUserDefaults] stringForKey:@"uid"];
            _token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
            
            if (userId) {
                _teacher = [UBTeacher find:userId];
            }
        }
        else {
            _teacher = teacher;
        }
    }
    return self;
}

- (BOOL)loggedIn
{
    if (self.teacher) {
        return YES;
    }
    else {
        return NO;
    }
}

- (void)logIn:(NSString *)email password:(NSString *)password success:(void (^)())success failure:(void (^)())failure
{
    [UBRequest post:@"session/auth" data:@{@"email": email, @"password": password} callback:^(NSDictionary *data) {
        if (data[@"token"]) {
            _token = data[@"token"];
            _teacher = (UBTeacher *) [UBTeacher findOrCreateWithDict:data[@"teacher"]];
            
            if (success) {
                success();
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotifName object:nil];
        }
        else {
            if (failure) {
                failure();
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginFailureNotifName object:nil];
        }
    }];
}

@end
