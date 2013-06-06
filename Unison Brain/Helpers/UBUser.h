//
//  UBUser.h
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kLoginSuccessNotifName @"loginSuccess"
#define kLoginFailureNotifName @"loginFailure"
#define kLoginExpiredNotifName @"loginExpire"
#define kLogoutNotifName @"logout"

@class UBTeacher;

@interface UBUser : NSObject

@property (nonatomic, readonly) UBTeacher *teacher;
@property (nonatomic, readonly) BOOL loggedIn;
@property (nonatomic, readonly) NSString *token;

+ (UBUser *)currentUser;
+ (UBTeacher *)currentTeacher;

- (id)initWithTeacher:(UBTeacher *)teacher;

- (void)logIn:(NSString *)username password:(NSString *)password success:(void (^)())success failure:(void (^)())failure;
- (void)logOut;

@end
