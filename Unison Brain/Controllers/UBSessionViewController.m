//
//  UBSessionViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBSessionViewController.h"

#import "UBSession.h"

#import "UBStudentSelectorView.h"

@interface UBSessionViewController ()

@property UBStudentSelectorView *studentSelector;

@end

@implementation UBSessionViewController

@synthesize session = _session;
@synthesize studentSelector = _studentSelector;

- (id)initWithSession:(UBSession *)session
{
    self = [super init];
    if (self) {
        _session = session;
        
        self.title = @"Unison Session";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _studentSelector = [[UBStudentSelectorView alloc] initWithStudents:_session.students.allObjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
