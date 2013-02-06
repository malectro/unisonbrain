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

@interface UBSessionViewController ()

@property UBSessionView *sessionView;
@property UBStudentSelectorView *studentSelector;
@property UBStudentListViewController *listController;
@property (nonatomic) NSArray *breaches;
@property (nonatomic) UBBreach *selectedBreach;
@property (nonatomic) NSIndexPath *selectedIndexPath;

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UBContribution *contribution = [self contributionForIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@: %@", contribution.person.fname, contribution.text];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *header = [[UILabel alloc] init];
    UBBreach *breach = [self breachForSection:section];
    
    header.text = [NSString stringWithFormat:@"%@ - %@", breach.studentList, [UBDate stringFromDateMedium:breach.time]];
    
    return header;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *headerView = nil;
    NSIndexPath *previousIndexPath = [tableView indexPathForSelectedRow];
    
    if (previousIndexPath != nil) {
        headerView = [tableView headerViewForSection:previousIndexPath.section];
        headerView.backgroundColor = [UIColor whiteColor];
    }
    
    headerView = [tableView headerViewForSection:indexPath.section];
    headerView.backgroundColor = [UIColor blueColor];
    
    _selectedBreach = [self breachForIndexPath:indexPath];
    
    return indexPath;
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
    [_sessionView.breachesView reloadData];
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
    
    // probs should make this prettier
    [_sessionView.breachesView reloadData];
    //[self.sessionView.breachesView insertRow]
}

@end
