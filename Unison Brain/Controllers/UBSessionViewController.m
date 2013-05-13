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

#import "UBModel.h"
#import "UBSession.h"
#import "UBCodeType.h"
#import "UBBreach.h"
#import "UBContribution.h"
#import "UBPerson.h"
#import "UBSubject.h"

#import "UBCodesViewController.h"
#import "UBStudentListViewController.h"

#import "UBSessionView.h"
#import "UBStudentSelectorView.h"
#import "UBContributionCell.h"
#import "UBBreachHeaderView.h"

@interface UBSessionViewController ()

@property UBSessionView *sessionView;
@property UBStudentSelectorView *studentSelector;
@property UBStudentListViewController *listController;
@property (nonatomic) UBCodesViewController *codesController;
@property (nonatomic) NSArray *breaches;
@property (nonatomic) UBBreach *selectedBreach;
@property (nonatomic) UBCodeType *chosenType;
@property (nonatomic) NSCache *headers;
@property (nonatomic, retain) UIPopoverController *popover;


@end

@implementation UBSessionViewController

@synthesize session = _session;
@synthesize studentSelector = _studentSelector;
@synthesize popover;

- (id)initWithSession:(UBSession *)session
{
    self = [super init];
    if (self) {
        _session = session;
        
        self.title = [NSString stringWithFormat:@"Session with %@ |  %@", session.studentList, [UBDate stringFromDateMedium:session.time]];
        
        _listController = [[UBStudentListViewController alloc] initWithItems:nil];
        _listController.delegate = self;
        [self addChildViewController:_listController];
        
        _codesController = [[UBCodesViewController alloc] initWithItems:nil];
        _codesController.delegate = self;
        [self addChildViewController:_codesController];
        
        _headers = [[NSCache alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadBreaches) name:@"UBBreach:fetchAll" object:nil];
        
        [self.session fetchBreaches];
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
    _studentSelector.students = _session.people.allObjects;
    [_studentSelector addTarget:self action:@selector(contribute)];
    
    self.sessionView.listSelectView = _listController.view;
    [_listController setSelection:_session.students.allObjects];
    
    [self.sessionView.codesOrStudents addTarget:self action:@selector(changeSideList:) forControlEvents:UIControlEventValueChanged];
    
    NSArray *barItems = @[
                          [[UIBarButtonItem alloc] initWithCustomView:self.sessionView.codesOrStudents],
                          [[UIBarButtonItem alloc] initWithCustomView:self.sessionView.subject]
                          ];
    
    self.navigationItem.rightBarButtonItems = barItems;
    
    [self.sessionView.createBreach addTarget:self action:@selector(chooseType) forControlEvents:UIControlEventTouchUpInside];

    [self.sessionView.changeDate addTarget:self action:@selector(changeDate) forControlEvents:UIControlEventTouchUpInside];

    self.sessionView.breachesView.delegate = self;
    self.sessionView.breachesView.dataSource = self;
}

- (void)reloadBreaches
{
    _breaches = nil;
    self.session = [UBSession find:self.session.id];
    [self.sessionView.breachesView reloadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_session save];
    [_session sync];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchList:(UBSearchListViewController *)searchList didSelectItem:(id)item
{
    if (searchList == _listController) {
        [_session addPeopleObject:item];
        _studentSelector.students = _session.people.allObjects;
        [self reloadTitle];

    }
    else {
        [_selectedBreach addCodesObject:item];
        [self.sessionView.breachesView reloadData];
    
    }
}

- (void)searchList:(UBSearchListViewController *)searchList didDeselectItem:(id)item
{
    if (searchList == _listController) {
        [_session removePeopleObject:item];
        _studentSelector.students = _session.people.allObjects;
        [self reloadTitle];


    }
    else {
        [_selectedBreach removeCodesObject:item];
        [self.sessionView.breachesView reloadData];

        
    }
}

- (void)removeStudents
{
    [_session removePeople:_studentSelector.selectedStudents];
    _studentSelector.students = _session.students.allObjects;
}

- (void)changeSideList:(UISegmentedControl *)control
{
    if (control.selectedSegmentIndex == 0) {
        self.sessionView.listSelectView = _listController.view;
    }
    else {
        self.sessionView.listSelectView = _codesController.view;
        if (self.selectedBreach != nil) {
            [_codesController setSelection:self.selectedBreach.codes.allObjects];
        }
    }
}


#pragma mark - Session Methods

- (void)changeDate
{
    
    UBDatePickerViewController *datePickerController = [[UBDatePickerViewController alloc]init];
    [datePickerController setDelegate:self];
    [datePickerController.datePicker setDate:_session.time animated:YES];
    [datePickerController setSession:_session];
    
    popover = [[UIPopoverController alloc] initWithContentViewController:datePickerController];
    popover.delegate = self;
    popover.popoverContentSize = datePickerController.datePicker.frame.size;
    
    [popover presentPopoverFromRect:_sessionView.changeDate.frame inView:_sessionView permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    [self reloadTitle];
    
}

- (void)reloadTitle
{
    self.title = [NSString stringWithFormat:@"Session with %@ | %@   ", _session.studentList, [UBDate stringFromDateMedium:_session.time]];
}



#pragma mark - Breach/Contribution Table View Methods

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

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UBContribution *contribution = [self contributionForIndexPath:indexPath];
//    
//    [NSString]
//    contribution.text
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UBBreach *breach = [self breachForSection:section];
    UBBreachHeaderView *header = [_headers objectForKey:breach];
    
    if (header == nil) {
        header = [[UBBreachHeaderView alloc] init];
        [header addTarget:header action:@selector(setSelfSelected) forControlEvents:UIControlEventTouchUpInside];
        header.delegate = self;
        header.breach = breach;
        [_headers setObject:header forKey:breach];
    }
    
    if (breach == self.selectedBreach) {
        header.selected = YES;
    }
    
    [header reloadHeader];
    
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //REMOVE THE CONTRIBUTION at indexPath
        UBModel *modelToDestroy = [self contributionForIndexPath:indexPath];
        [modelToDestroy destroy];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


#pragma mark - Breach Methods

- (void)setSelectedBreach:(UBBreach *)selectedBreach
{
    NSInteger section = 0;
    UBBreachHeaderView *headerView = nil;
    
    if (self.selectedBreach != nil) {
        section = [self.breaches indexOfObject:self.selectedBreach];
        headerView = (UBBreachHeaderView *)[self tableView:nil viewForHeaderInSection:section];
        headerView.selected = NO;
    }
    
    section = [self.breaches indexOfObject:selectedBreach];
    headerView = (UBBreachHeaderView *)[self tableView:nil viewForHeaderInSection:section];
    headerView.selected = YES;
    
    _selectedBreach = selectedBreach;
    
    [_codesController setSelection:_selectedBreach.codes.allObjects];
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

- (void)chooseType
{
        
    UIActionSheet *typeChooser = [[UIActionSheet alloc]initWithTitle:@"Choose Type" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    for (int i=0; i < [UBCodeType all].count; i++){
        NSString *name = [[UBCodeType all][i] valueForKey:@"name"];
        [typeChooser addButtonWithTitle:name];
    }
    
    [typeChooser showFromRect:_sessionView.createBreach.frame inView:_sessionView animated:YES];
    
}

- (void)createBreachWithType:(UBCodeType *)type
{
    UBBreach *breach = [UBBreach create];
    breach.codeType = type;
    
    // not sure we need this at all
    [breach addPeople:_session.people];
    
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

#pragma mark - UIActionSheet Delegate Methods


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == -1 || buttonIndex == 4) {
        return;
        // this is meant to make there be no new breach if you don't select a button.
        // but it might be screwing up right now.

    }
    else {
        UBCodeType *type = [UBCodeType all][buttonIndex];
        [self createBreachWithType:type];
    }
}


@end
