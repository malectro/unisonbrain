//
//  UBHomeViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBHomeViewController.h"

#import "UBUser.h"

@interface UBHomeViewController ()

@end

@implementation UBHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view = [[UIView alloc] init];
        self.view.backgroundColor = [UIColor grayColor];
        
        UBUser *user = [UBUser currentUser];
        
        // test user stuff
        UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        testLabel.text = user.teacher.fname;
        [self.view addSubview:testLabel];
        
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
