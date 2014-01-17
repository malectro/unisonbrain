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
#import "UBStudentViewController.h"
#import "UBHomeStudentListControllerViewController.h"

#import "UBHomeView.h"

@interface UBHomeViewController ()

@property UBSessionsViewController *sessionsViewController;
@property UBStudentListViewController *studentsViewController;
@property UBHomeView *homeView;
@property (nonatomic) UIBarButtonItem *logoutButton;

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
        
        _studentsViewController = [[UBHomeStudentListControllerViewController alloc] initWithTeacher:[UBUser currentTeacher]];
        
        _studentsViewController.delegate = self;
        [self addChildViewController:_studentsViewController];
        
        [_studentsViewController setAllowsMultipleSelection:NO];

        
        _logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
        self.navigationItem.rightBarButtonItem = _logoutButton;
        
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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(createSession)];
    
    [_studentsViewController.tableView reloadData];

    
    self.homeView.sessionsView = _sessionsViewController.view;
    self.homeView.studentsView = _studentsViewController.view;
    //self.homeView.teacherNameLabel.text = [UBUser currentUser].teacher.fname;
    //[self.homeView.createSessionButton addTarget:self action:@selector(createSession) forControlEvents:UIControlEventTouchDown];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.studentsViewController.tableView setAllowsMultipleSelection:NO];

    [[UBUser currentUser] reloadTeacher];
    
    
    self.sessionsViewController.teacher = [UBUser currentTeacher];
    self.studentsViewController.teacher = [UBUser currentTeacher];
    
    [_studentsViewController setAllowsMultipleSelection:NO];

    
    //self.homeView.teacherNameLabel.text = [UBUser currentUser].teacher.name;
    self.title = [NSString stringWithFormat:@"Unison Home - %@", [UBUser currentTeacher].name];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [self.studentsViewController.tableView deselectRowAtIndexPath:[self.studentsViewController.tableView indexPathForSelectedRow] animated:NO];
    
    [self.studentsViewController.searchDisplayController setActive:NO];
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

- (void)logOut
{
    [[UBUser currentUser] logOut];
}

# pragma mark - UB Search List Delegate Methods

- (void)searchList:(UBSearchListViewController *)searchList didSelectItem:(UBStudent *)item
{
    UBStudentViewController *studentViewController = [[UBStudentViewController alloc] initWithStudent:item];
    [self.navigationController pushViewController:studentViewController animated:YES];
    
    [self.studentsViewController.tableView deselectRowAtIndexPath:[self.studentsViewController.tableView indexPathForSelectedRow] animated:NO];

}

- (void) reloadData {
    
    [self.sessionsViewController.tableView reloadData];
    [self.studentsViewController.tableView reloadData];
    
    
}

@end


