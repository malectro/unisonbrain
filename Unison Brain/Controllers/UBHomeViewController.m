//
//  UBHomeViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBHomeViewController.h"

#import "UBAppDelegate.h"
#import "UBUser.h"

#import "UBSession.h"
#import "UBTeacher.h"
#import "UBStudent.h"

#import "UBSessionsViewController.h"
#import "UBSessionViewController.h"

#import "UBHomeView.h"

@interface UBHomeViewController ()

@property UBSessionsViewController *sessionsViewController;
@property UBStudentListViewController *studentsViewController;
@property UBHomeView *homeView;

@end

@implementation UBHomeViewController

@synthesize sessionsViewController = _sessionsViewController,
            studentsViewController = _studentsViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {        
      
        _sessionsViewController = [[UBSessionsViewController alloc] initWithTeacher:[UBUser currentUser].teacher];
        [self addChildViewController:_sessionsViewController];
        
        _studentsViewController = [[UBStudentListViewController alloc] init];
        _studentsViewController.delegate = self;
        _studentsViewController.tableView.allowsMultipleSelection = NO;
        [self addChildViewController:_studentsViewController];
        
        self.title = @"Unison Home";
    }
    return self;
}

- (void)loadView
{
    self.view = self.homeView = [[UBHomeView alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.homeView.sessionsView = _sessionsViewController.tableView;
    self.homeView.studentsView = _studentsViewController.view;
    self.homeView.teacherNameLabel.text = [UBUser currentUser].teacher.fname;
    [self.homeView.createSessionButton addTarget:self action:@selector(createSession) forControlEvents:UIControlEventTouchDown];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createSession
{
    UBSession *session = [UBSession create];
    
    [session addPeopleObject:[UBUser currentUser].teacher];
    
    UBSessionViewController *sessionViewController = [[UBSessionViewController alloc] initWithSession:session];
    [self.navigationController pushViewController:sessionViewController animated:YES];
}

# pragma mark UB Search List Delegate Methods

- (void)searchList:(UBSearchListViewController *)searchList didSelectItem:(id)item{
    
    // MAKE STUDENT / CONFERENCE PAGE FOR SELECTED STUDENT
    
}


@end


