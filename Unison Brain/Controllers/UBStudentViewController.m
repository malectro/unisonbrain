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

@interface UBStudentViewController ()

@end

@implementation UBStudentViewController

- (id)initWithStudent:(UBStudent *)student
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        if (student != nil) {
            self.student = student;
        }
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
	// Do any additional setup after loading the view.
}

- (void)setStudent:(UBStudent *)student
{
    self.title = student.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
