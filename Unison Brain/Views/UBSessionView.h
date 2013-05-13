//
//  UBSessionView.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UBStudentSelectorView.h"

@class UBSubject;

@interface UBSessionView : UIView

@property (nonatomic) UBStudentSelectorView *studentSelector;
@property (nonatomic) UIView *listSelectView;
@property (nonatomic, readonly) UITableView *breachesView;

@property (nonatomic, readonly) UIButton *createBreach;
@property (nonatomic, readonly) UIButton *changeDate;
@property (nonatomic, readonly) UISegmentedControl *codesOrStudents;
@property (nonatomic, readonly) UISegmentedControl *subject;
@property (nonatomic) UBSubject *selectedSubject;

- (void)shrinkForTyping;
- (void)doneTyping;


@end
