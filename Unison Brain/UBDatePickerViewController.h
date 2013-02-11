//
//  UBDatePickerViewController.h
//  Unison Brain
//
//  Created by Amy Piller on 2/10/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBSession.h"


@protocol UBDatePickerDelegate

@optional
- (void)reloadDate;
- (void)setSessionDate:(NSDate*)date;
- (NSDate *)dateToStart;

@end

@interface UBDatePickerViewController : UIViewController

@property (strong, nonatomic) UBSession *session;
@property (weak, nonatomic) NSObject<UBDatePickerDelegate> *delegate;

@property (strong, nonatomic) UIDatePicker *datePicker;


@end
