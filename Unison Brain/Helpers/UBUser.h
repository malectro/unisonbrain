//
//  UBUser.h
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UBTeacher.h"

@interface UBUser : NSObject

@property (nonatomic, retain, readonly) UBTeacher *teacher;

+ (UBUser *)currentUser;

- (id)initWithTeacher:(UBTeacher *)teacher;

@end
