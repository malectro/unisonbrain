//
//  UBConferenceCommentViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/25/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBConferenceCommentViewController.h"

#import "UBFunctions.h"

#import "UBCodeScore.h"
#import "UBConference.h"
#import "UBSubject.h"

#import "UBSelectPopover.h"
#import "UBCodeScoreCell.h"
#import "UBCodesViewController.h"

@interface UBConferenceCommentViewController () {
    CGFloat _codesControllerPosition;
    BOOL _codesControllerHidden;
    UBCodeScoreCell *_lastSelectedCell;
}

@property (nonatomic) UBCodesViewController *codesController;
@property (nonatomic) UBSelectPopover *popover;
@property (nonatomic) UBCodeScoreCell *selectedCodeScoreCell;
@property (nonatomic) NSArray *subjects;

@end

@implementation UBConferenceCommentViewController

- (id)initWithConference:(UBConference *)conference
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        if (conference != nil) {
            _conference = conference;
        }
        
        self.modelName = @"UBCodeScore";
        
        _codesController = [[UBCodesViewController alloc] init];
        _codesController.subject = self.conference.subject;
        _codesControllerHidden = YES;
        
        self.subjects = [UBSubject all];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.codesController.delegate = self;
    [self.view addSubview:self.codesController.view];
    self.codesController.allowsMultipleSelection = NO;
    self.codesController.allowsSelectionGrouping = YES;
    _codesControllerPosition = 0;
    
    UIView *headerView = [[UIView alloc] init];
    UILabel *headerLabel = [[UILabel alloc] init];
    
    headerView.frame = CGRectMake(0, 0, 0, 44.0f);
    
    headerLabel.text = @"New Comment";
    [headerLabel sizeToFit];
    headerLabel.frame = CGRectPosition(headerLabel.frame, 10.0f, 0);
    
    //[headerView addSubview:headerLabel];
    
    UIButton *headerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    headerButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [headerButton setTitle:@"New Comment" forState:UIControlStateNormal];
    headerButton.frame = CGRectMake(10.0f, 5.0f, 150.0f, 30.0f);
    
    [headerButton addTarget:self action:@selector(createCodeScore) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:headerButton];
    
    self.subjectControl = [[UISegmentedControl alloc] initWithItems:[self.subjects valueForKey:@"name"]];
    self.subjectControl.frame = CGRectMake(310.0f, 5.0f, 700.0f, 30.0f);
    [self.subjectControl setTitleTextAttributes:@{UITextAttributeFont: [UIFont systemFontOfSize:16.0f]} forState:UIControlStateNormal];
    [headerView addSubview:self.subjectControl];
    [self.subjectControl addTarget:self action:@selector(changedSubject) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.tableHeaderView = headerView;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (_codesControllerPosition == 0) {
        _codesControllerPosition = self.view.frame.size.width;
        //_codesControllerPosition = self.view.frame.size.width - 400.0f;
    }
    
    self.codesController.view.frame = CGRectMake(_codesControllerPosition, 0, 400.0f, self.view.frame.size.height);
    [self.view bringSubviewToFront:self.codesController.view];
}

- (void)showCodesView
{
    _codesControllerPosition = self.view.frame.size.width - 400.0f;
    [UIView animateWithDuration:0.2f animations:^{
        self.codesController.view.frame = CGRectMake(_codesControllerPosition, 0, 400.0f, self.view.frame.size.height);
    }];
}

- (void)hideCodesView
{
    _codesControllerPosition = self.view.frame.size.width;
    [UIView animateWithDuration:0.2f animations:^{
        self.codesController.view.frame = CGRectMake(_codesControllerPosition, 0, 400.0f, self.view.frame.size.height);
    }];
}

- (void)setConference:(UBConference *)conference
{
    _conference = conference;
    
    if (self.conference.subject) {
        self.subjectControl.selectedSegmentIndex = [self.subjects indexOfObject:self.conference.subject];
        self.codesController.subject = _conference.subject;
    }
    
    [self reload];
}

- (NSArray *)sortDescriptors
{
    NSSortDescriptor *sortDescriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"code.name" ascending:NO];
    return @[sortDescriptor2];
}

- (NSPredicate *)predicate
{
    return [NSPredicate predicateWithFormat:@"conference = %@", self.conference];
}

- (NSString *)cacheName
{
    return [NSString stringWithFormat:@"UBConference %@", self.conference.id];
}

- (void)configureCell:(UBCodeScoreCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    UBCodeScore *codeScore = [self codeScoreForIndexPath:indexPath];
    cell.codeScore = codeScore;
}

- (UITableViewCell *)allocCell:(NSString *)identifer
{
    UBCodeScoreCell *cell = [[UBCodeScoreCell alloc] initWithReuseIdentifier:identifer];
    cell.conferenceController = self;
    [cell.textField addTarget:self action:@selector(hideCodesView) forControlEvents:UIControlEventEditingDidBegin];
    return cell;
}

- (UBCodeScore *)codeScoreForIndexPath:(NSIndexPath *)indexPath
{
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

- (void)createCodeScore
{
    UBCodeScore *codeScore = [UBCodeScore create];
    codeScore.conference = self.conference;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UBCodeScore *codeScore = [self codeScoreForIndexPath:indexPath];
    
    if (codeScore.code) {
        [self.codesController setSelection:@[codeScore.code]];
    }
    
    if (_codesControllerHidden) {
        [self showCodesView];
    }
    else {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        [self hideCodesView];
    }
}

- (void)searchList:(UBSearchListViewController *)searchList didSelectItem:(UBCode *)item
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UBCodeScoreCell *codeScoreCell = (UBCodeScoreCell *) [self.tableView cellForRowAtIndexPath:indexPath];
    
    codeScoreCell.codeScore.code = item;
    
    [self configureCell:codeScoreCell atIndexPath:indexPath];
    
    [self hideCodesView];
}

- (void)searchList:(UBSearchListViewController *)searchList didDeselectItem:(UBCode *)item
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UBCodeScoreCell *codeScoreCell = (UBCodeScoreCell *) [self.tableView cellForRowAtIndexPath:indexPath];
    
    codeScoreCell.codeScore.code = nil;
    
    [self configureCell:codeScoreCell atIndexPath:indexPath];
}

- (void)touchedNotionForCodeScore:(UBCodeScoreCell *)codeScore
{
    self.popover = [[UBSelectPopover alloc] initWithItems:[UBCodeScore notions]];
    [self.popover presentPopoverFromRect:codeScore.notionLabel.frame inView:codeScore permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [self.popover addTarget:self action:@selector(selectedNotion)];
    self.selectedCodeScoreCell = codeScore;
}

- (void)selectedNotion
{
    [self.popover dismissPopoverAnimated:YES];
    
    NSString *notion = [UBCodeScore notions][self.popover.selectedIndex];
    self.selectedCodeScoreCell.codeScore.notion = notion;
    self.selectedCodeScoreCell.notionLabel.text = notion;
}

- (void)changedSubject
{
    NSInteger index = self.subjectControl.selectedSegmentIndex;
    UBSubject *subject = nil;
    
    if (index > -1) {
        subject = self.subjects[index];
    }
    
    self.conference.subject = subject;
    self.codesController.subject = subject;
}

@end
