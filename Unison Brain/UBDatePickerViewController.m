//
//  UBDatePickerViewController.m
//  Unison Brain
//
//  Created by Amy Piller on 2/10/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBDatePickerViewController.h"

@interface UBDatePickerViewController ()

@end

@implementation UBDatePickerViewController

@synthesize session;
@synthesize datePicker;

- (id)init {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        datePicker = [[UIDatePicker alloc]init];

    }
    return self;
}

- (void) loadView
{
    self.view = datePicker;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self configureView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) configureView{
    
    //  NSDate *startDate = [delegate dateToStart];
    //  //if (startDate) {
    //  [self.datePicker setDate:startDate];
    //}
    
}


-(void) viewWillDisappear:(BOOL)animated{
    
    NSDate *newDate = datePicker.date;
    session.time = newDate;
    [session save];
        
    
}



@end
