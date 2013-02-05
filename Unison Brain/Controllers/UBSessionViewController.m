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

#import "UBSessionView.h"
#import "UBStudentSelectorView.h"

@interface UBSessionViewController ()

@property UBSessionView *sessionView;
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
        
        _listController = [[UBStudentListViewController alloc] initWithStudents:nil];
        _listController.delegate = self;
        [self addChildViewController:_listController];
    }
    return self;
}

- (void)loadView
{
    self.view = self.sessionView = [[UBSessionView alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _studentSelector = self.sessionView.studentSelector;
    _studentSelector.students = _session.students.allObjects;
    
    self.sessionView.listSelectView = _listController.view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSelectItem:(UBPerson *)item
{
    NSLog(@"did select item %@", item);
    [_session addPeopleObject:item];
    _studentSelector.students = _session.students.allObjects;
}

@end
