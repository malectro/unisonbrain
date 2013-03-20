//
//  UBStudentViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/19/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBStudentViewController.h"

#import "UBUser.h"

#import "UBStudent.h"
#import "UBConference.h"

#import "UBStudentView.h"
#import "UBContributionsViewController.h"
#import "UBConferenceCommentViewController.h"
#import "UBCodeScoresViewController.h"
#import "UBConferencesViewController.h"

@interface UBStudentViewController () {
    UBConference *_selectedConference;
}

@property (nonatomic) UBContributionsViewController *contributionsController;
@property (nonatomic) UBCodeScoresViewController *codesController;
@property (nonatomic) UBConferencesViewController *conferencesController;
@property (nonatomic) UBConferenceCommentViewController *conferenceController;

@end

@implementation UBStudentViewController

- (id)initWithStudent:(UBStudent *)student
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        if (student != nil) {
            self.student = student;
        }
        
        _contributionsController = [[UBContributionsViewController alloc] initWithPerson:self.student];
        [self addChildViewController:_contributionsController];
        
        _codesController = [[UBCodeScoresViewController alloc] initWithStudent:self.student];
        [self addChildViewController:_codesController];
        
        _conferencesController = [[UBConferencesViewController alloc] initWithStudent:self.student];
        [self addChildViewController:_conferencesController];
        
        _conferenceController = [[UBConferenceCommentViewController alloc] initWithConference:[UBConference create]];
        [self addChildViewController:_conferenceController];
    }
    return self;
}

- (void)loadView
{
    self.view = _studentView = [[UBStudentView alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.studentView.contributionsView = self.contributionsController.view;
    self.studentView.codesView = self.codesController.view;
    self.studentView.conferencesView = self.conferencesController.view;
    self.studentView.conferenceView = self.conferenceController.view;
    
    [self.studentView.createConference addTarget:self action:@selector(createConference) forControlEvents:UIControlEventTouchDown];
    
    self.studentView.conferenceMetaView.delegate = self;
    [self.conferencesController addRowSelectionTarget:self action:@selector(selectConference:)];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_selectedConference != nil) {
        [_selectedConference save];
        [_selectedConference sync];
    }
}

- (void)setStudent:(UBStudent *)student
{
    _student = student;
    self.title = student.name;
    [_student fetchConferences];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createConference
{
    UBConference *conference = [UBConference create];
    conference.student = self.student;
    conference.teacher = [UBUser currentTeacher];
    [self selectConference:conference];
}

- (void)selectConference:(UBConference *)conference
{
    _selectedConference = conference;
    self.conferenceController.conference = conference;
    [self.studentView showConferenceView];
}

@end
