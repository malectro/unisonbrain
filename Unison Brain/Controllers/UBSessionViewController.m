//
//  UBSessionViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBSessionViewController.h"

#import "UBDate.h"

#import "UBSession.h"
#import "UBBreach.h"

#import "UBStudentListViewController.h"

#import "UBSessionView.h"
#import "UBStudentSelectorView.h"

@interface UBSessionViewController ()

@property UBSessionView *sessionView;
@property UBStudentSelectorView *studentSelector;
@property UBStudentListViewController *listController;
@property (nonatomic) NSArray *breaches;

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
    
    [self.sessionView.removeStudents addTarget:self action:@selector(removeStudents) forControlEvents:UIControlEventTouchDown];
    [self.sessionView.createBreach addTarget:self action:@selector(createBreach) forControlEvents:UIControlEventTouchDown];
    
    self.sessionView.breachesView.delegate = self;
    self.sessionView.breachesView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSelectItem:(UBPerson *)item
{
    [_session addPeopleObject:item];
    _studentSelector.students = _session.students.allObjects;
}

- (void)removeStudents
{
    [_session removePeople:_studentSelector.selectedStudents];
    _studentSelector.students = _session.students.allObjects;
}

#pragma mark - Breaches Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _session.breaches.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UBBreach *breach = [self breachForIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", breach.studentList, [UBDate stringFromDateMedium:breach.time]];
    
    return cell;
}

- (UBBreach *)breachForIndexPath:(NSIndexPath *)indexPath
{
    return self.breaches[indexPath.row];
}

- (NSArray *)breaches
{
    if (_breaches == nil) {
        _breaches = _session.sortedBreaches;
    }
    return _breaches;
}

- (void)createBreach
{
    UBBreach *breach = [UBBreach create];
    
    [breach addPeople:_studentSelector.selectedStudents];
    
    [_session addBreachesObject:breach];
    _breaches = nil;
    [_sessionView.breachesView reloadData];
}

@end
