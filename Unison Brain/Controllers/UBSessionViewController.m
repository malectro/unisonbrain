//
//  UBSessionViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBSessionViewController.h"

#import "UBDate.h"
#import "UBAlert.h"

#import "UBSession.h"
#import "UBBreach.h"
#import "UBContribution.h"
#import "UBPerson.h"

#import "UBStudentListViewController.h"

#import "UBSessionView.h"
#import "UBStudentSelectorView.h"
#import "UBContributionCell.h"

@interface UBSessionViewController ()

@property UBSessionView *sessionView;
@property UBStudentSelectorView *studentSelector;
@property UBStudentListViewController *listController;
@property (nonatomic) NSArray *breaches;
@property (nonatomic) UBBreach *selectedBreach;
@property (nonatomic) NSCache *headers;

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
        
        _headers = [[NSCache alloc] init];
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
    [self.sessionView.contribute addTarget:self action:@selector(contribute) forControlEvents:UIControlEventTouchDown];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.breaches.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((UBBreach *) self.breaches[section]).contributions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UBContributionCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UBContributionCell alloc] initWithReuseIdentifier:CellIdentifier];
    }
    
    UBContribution *contribution = [self contributionForIndexPath:indexPath];
    cell.contribution = contribution;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UBBreach *breach = [self breachForSection:section];
    UILabel *header = [_headers objectForKey:breach];
    
    if (header == nil) {
        header = [[UILabel alloc] init];
        header.text = [NSString stringWithFormat:@"%@ - %@", breach.studentList, [UBDate stringFromDateMedium:breach.time]];
        [_headers setObject:header forKey:breach];
    }
    
    if (breach == self.selectedBreach) {
        header.backgroundColor = [UIColor blueColor];
    }
    else {
        header.backgroundColor = [UIColor whiteColor];
    }
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    self.selectedBreach = [self breachForIndexPath:indexPath];
    
    return indexPath;
}

- (void)setSelectedBreach:(UBBreach *)selectedBreach
{
    NSInteger section = 0;
    UILabel *headerView = nil;
    
    if (self.selectedBreach != nil) {
        section = [self.breaches indexOfObject:self.selectedBreach];
        headerView = (UILabel *)[self tableView:nil viewForHeaderInSection:section];
        headerView.backgroundColor = [UIColor whiteColor];
    }
    
    section = [self.breaches indexOfObject:selectedBreach];
    headerView = (UILabel *)[self tableView:nil viewForHeaderInSection:section];
    headerView.backgroundColor = [UIColor colorWithRed:0.8f green:0.8f blue:1.0f alpha:1.0f];
    
    _selectedBreach = selectedBreach;
}

- (UBContribution *)contributionForIndexPath:(NSIndexPath *)indexPath
{
    return [self breachForIndexPath:indexPath].sortedContributions[indexPath.row];
}

- (UBBreach *)breachForIndexPath:(NSIndexPath *)indexPath
{
    return [self breachForSection:indexPath.section];
}

- (UBBreach *)breachForSection:(NSInteger)section
{
    return self.breaches[section];
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
    
    if (_studentSelector.selectedStudents.count < 1) {
        [UBAlert alert:@"Select some students to create a breach."];
        return;
    }
    
    [breach addPeople:_studentSelector.selectedStudents];
    
    [_session addBreachesObject:breach];
    
    _breaches = nil;
    
    [_sessionView.breachesView insertSections:[NSIndexSet indexSetWithIndex:self.breaches.count - 1] withRowAnimation:UITableViewRowAnimationAutomatic];

    self.selectedBreach = breach;
}

- (void)contribute
{
    UBBreach *breach = self.selectedBreach;
    UBContribution *contribution = [UBContribution create];
    
    if (self.breaches.count < 1) {
        [UBAlert alert:@"There are no breaches in this session."];
        return;
    }
    
    if (_studentSelector.selectedStudents.count != 1) {
        [UBAlert alert:@"Please select a single student."];
        return;
    }
    
    if (breach == nil) {
        breach = self.breaches.lastObject;
    }
    
    contribution.breach = breach;
    contribution.time = [NSDate date];
    contribution.person = _studentSelector.selectedStudents.allObjects[0];
    
    breach.sortedContributions = nil;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:breach.contributions.count - 1 inSection:[self.breaches indexOfObject:breach]];
    [_sessionView.breachesView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    UBContributionCell *cell = (UBContributionCell *) [_sessionView.breachesView cellForRowAtIndexPath:indexPath];
    [cell.textField becomeFirstResponder];
}

@end
