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
#import "UBStudent.h"

#import "UBSessionsViewController.h"
#import "UBSessionViewController.h"

#import "UBHomeView.h"

@interface UBHomeViewController ()

@property UBSessionsViewController *sessionsViewController;
@property UBHomeView *homeView;

@end

@implementation UBHomeViewController

@synthesize sessionsViewController = _sessionsViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {        
        _sessionsViewController = [[UBSessionsViewController alloc] initWithTeacher:[UBUser currentUser].teacher];
        [self addChildViewController:_sessionsViewController];
        
        NSLog(@"students %@", [UBStudent all]);
    }
    return self;
}

- (void)loadView
{
    self.view = self.homeView = [[UBHomeView alloc] init];
    
    self.title = @"Unison Home";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.homeView.sessionsView = _sessionsViewController.tableView;
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
    
    session.people = [session.people setByAddingObject:[UBUser currentUser].teacher];
    
    UBSessionViewController *sessionViewController = [[UBSessionViewController alloc] initWithSession:session];
    [self.navigationController pushViewController:sessionViewController animated:YES];
}

@end
