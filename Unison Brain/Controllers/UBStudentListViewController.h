//
//  UBStudentListViewController.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/4/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UBSearchListViewController.h"

@class UBTeacher;

@interface UBStudentListViewController : UBSearchListViewController

@property (nonatomic) UBTeacher *teacher;

- (id)initWithTeacher:(UBTeacher *)teacher;

@end
