//
//  UBHomeView.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBStudentListViewController.h"

@interface UBHomeView : UIView

@property (nonatomic, retain, readonly) UILabel *teacherNameLabel;
@property (nonatomic, retain, readonly) UIButton *createSessionButton;
@property (nonatomic, retain) UIView *sessionsView;
@property (nonatomic, retain) UIView *studentsView;
@property (nonatomic, readonly) UIBarButtonItem *syncButton;

@end
