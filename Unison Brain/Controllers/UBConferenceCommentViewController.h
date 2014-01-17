//
//  UBConferenceCommentViewController.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/25/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBModelTableViewController.h"
#import "UBSearchListViewController.h"
#import "UBCodeScoresViewController.h"
#import "UBStudentView.h"


@class UBConference;
@class UBCodeScoreCell;

@interface UBConferenceCommentViewController : UBModelTableViewController<UBSearchListViewDelegate>

@property (nonatomic) UBConference *conference;
@property (nonatomic) UISegmentedControl *subjectControl;
@property (weak) UBCodeScoresViewController *codeScoresView;
@property (nonatomic) UBStudentView *studentView;



- (id)initWithConference:(UBConference *)conference;

- (void)touchedNotionForCodeScore:(UBCodeScoreCell *)codeScore;

- (void)shouldUpdateCodeScores;

- (void)shouldAutoscroll;

- (void)shouldAvoidKeyboard;


@end
