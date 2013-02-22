//
//  UBStudentViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/19/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBStudentViewController.h"

#import "UBStudent.h"

#import "UBStudentView.h"
#import "UBContributionsViewController.h"
#import "UBCodeScoresViewController.h"

@interface UBStudentViewController ()

@property (nonatomic) UBContributionsViewController *contributionsController;
@property (nonatomic) UBCodeScoresViewController *codesController;

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

    self.studentView.contributionsView = self.contributionsController.tableView;
    self.studentView.codesView = self.codesController.view;
}

- (void)setStudent:(UBStudent *)student
{
    _student = student;
    self.title = student.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
