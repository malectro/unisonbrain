//
//  UBHomeViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBHomeViewController.h"

#import "UBUser.h"
#import "UBSessionsViewController.h"
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

@end
