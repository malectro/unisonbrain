//
//  UBSessionViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBSessionViewController.h"

#import "UBSession.h"

#import "UBStudentListViewController.h"

#import "UBStudentSelectorView.h"

@interface UBSessionViewController ()

@property UBStudentSelectorView *studentSelector;
@property UBStudentListViewController *listController;

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
    [self.view addSubview:_studentSelector];
    
    _listController = [[UBStudentListViewController alloc] initWithStudents:nil];
    [self addChildViewController:_listController];
    [self.view addSubview:_listController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
