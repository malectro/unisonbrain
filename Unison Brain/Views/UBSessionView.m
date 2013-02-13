//
//  UBSessionView.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBSessionView.h"

#include "UBFunctions.h"

#import <QuartzCore/QuartzCore.h>

#import "UBSubject.h"
#import "UBType.h"

#define LEFT_WIDTH 770.0f
#define RIGHT_WIDTH (1024.0f - 770.0f)

@interface UBSessionView ()

@property (nonatomic) UILabel *selectorLabel;
@property (nonatomic) UIView *controlPanelBackground;

@end

@implementation UBSessionView

@synthesize studentSelector = _studentSelector;
@synthesize listSelectView = _listSelectView;
@synthesize createBreach = _createBreach;
@synthesize changeDate = _changeDate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        _breachesView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        //_breachesView.backgroundView.opaque = YES;
        [self addSubview:_breachesView];
        
        _controlPanelBackground = [[UIView alloc] init];
        _controlPanelBackground.backgroundColor = [UIColor whiteColor];
        _controlPanelBackground.layer.shadowColor = [UIColor blackColor].CGColor;
        _controlPanelBackground.layer.shadowOpacity = 0.5f;
        _controlPanelBackground.layer.shadowRadius = 10.0f;
        [self addSubview:_controlPanelBackground];
        
        self.studentSelector = [[UBStudentSelectorView alloc] initWithStudents:nil];
        
        // _removeStudents = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        // [_removeStudents setTitle:@"Remove Students" forState:UIControlStateNormal];
        // [_removeStudents sizeToFit];
        // [self addSubview:_removeStudents];
        
        _createBreach = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_createBreach setTitle:@"New Breach" forState:UIControlStateNormal];
        [_createBreach sizeToFit];
        [self addSubview:_createBreach];
        
        _changeDate = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_changeDate setTitle:@"Change Date" forState:UIControlStateNormal];
        [_changeDate sizeToFit];
        [self addSubview:_changeDate];
        
        _contribute = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_contribute setTitle:@"New Contribution" forState:UIControlStateNormal];
        [_contribute sizeToFit];
        [self addSubview:_contribute];
        
        self.selectorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.selectorLabel.text = @"People in This Session";
        [self.selectorLabel sizeToFit];
        [self addSubview:self.selectorLabel];
        
        _codesOrStudents = [[UISegmentedControl alloc] initWithItems:@[@"Students", @"Codes"]];
        _codesOrStudents.selectedSegmentIndex = 0;
        _codesOrStudents.segmentedControlStyle = UISegmentedControlStyleBar;
        [self addSubview:_codesOrStudents];
        
        NSArray *subjects = [UBSubject all];
        NSLog(@"%@", subjects);
        NSArray *subjectNames = [subjects valueForKey:@"name"];
        
        _subject = [[UISegmentedControl alloc] initWithItems:subjectNames];
        _subject.selectedSegmentIndex = -1;
        _subject.segmentedControlStyle = UISegmentedControlStyleBar;
        [self addSubview:_subject];
        
        NSArray *typeNames = [[UBType all] valueForKey:@"name"];
        
    }
    return self;
}

- (void)layoutSubviews
{
    // segemnted control is to be added as a nav item
    // _codesOrStudents.frame = CGRectPosition(_codesOrStudents.frame, LEFT_WIDTH, 0);
    
    if (_studentSelector) {
        _studentSelector.frame = CGRectMake(10.0f, self.frame.size.height - 54.0f, LEFT_WIDTH - 20.0f, 54.0f);
    }
    if (_listSelectView) {
        _listSelectView.frame = CGRectMake(LEFT_WIDTH, 0, RIGHT_WIDTH, self.frame.size.height);
    }
    
    self.selectorLabel.frame = CGRectPosition(self.selectorLabel.frame, 10.0f, _studentSelector.frame.origin.y - self.selectorLabel.frame.size.height - 5.0f);
    
    _createBreach.frame = CGRectPosition(_createBreach.frame, 10.0f, self.selectorLabel.frame.origin.y - 44.0f);
    _contribute.frame = CGRectPosition(_contribute.frame, _createBreach.frame.origin.x + _createBreach.frame.size.width + 2.0f, _createBreach.frame.origin.y);
    _changeDate.frame = CGRectPosition(_changeDate.frame, _contribute.frame.origin.x + _contribute.frame.size.width +2.0f, _createBreach.frame.origin.y);
    
    _breachesView.frame = CGRectMake(0, 0, LEFT_WIDTH - 1.0f, _createBreach.frame.origin.y - 10.0f);
    _controlPanelBackground.frame = CGRectMake(0, _breachesView.frame.size.height, LEFT_WIDTH - 1.0f, self.frame.size.height - _breachesView.frame.size.height);
    
    
}

- (void)setListSelectView:(UIView *)listSelectView
{
    _listSelectView = listSelectView;
    [_listSelectView removeFromSuperview];
    
    //_listSelectView.layer.borderColor = [UIColor blackColor].CGColor;
    //_listSelectView.layer.borderWidth = 1.0f;
    _listSelectView.layer.shadowColor = [UIColor blackColor].CGColor;
    _listSelectView.layer.shadowRadius = 10.0f;
    _listSelectView.layer.shadowOpacity = 0.5f;
    
    [self addSubview:_listSelectView];
    [self bringSubviewToFront:_listSelectView];
}

- (void)setStudentSelector:(UBStudentSelectorView *)studentSelector
{
    _studentSelector = studentSelector;
    [_studentSelector removeFromSuperview];
    [self addSubview:_studentSelector];
}

@end
