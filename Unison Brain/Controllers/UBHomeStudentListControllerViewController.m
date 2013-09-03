//
//  UBHomeStudentListControllerViewController.m
//  unison
//
//  Created by Joseph Posner on 9/3/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBHomeStudentListControllerViewController.h"

@interface UBHomeStudentListControllerViewController ()

@end

@implementation UBHomeStudentListControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.allowsMultipleSelection = NO;
    self.allowsSelectionGrouping = NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
