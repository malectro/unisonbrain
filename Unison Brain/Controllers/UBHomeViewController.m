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
        self.view = self.homeView = [[UBHomeView alloc] init];
        
        UBUser *user = [UBUser currentUser];
        self.homeView.teacherNameLabel.text = user.teacher.fname;
        
        _sessionsViewController = [[UBSessionsViewController alloc] initWithTeacher:user.teacher];
        [self addChildViewController:_sessionsViewController];
        self.homeView.sessionsView = _sessionsViewController.tableView;
        
        [self.homeView.createSessionButton addTarget:self action:@selector(createSession) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
