//
//  UBSessionView.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBSessionView.h"

#include "UBFunctions.h"

#define LEFT_WIDTH 770.0f
#define RIGHT_WIDTH (1024.0f - 770.0f)

@interface UBSessionView ()

@property (nonatomic) UILabel *selectorLabel;

@end

@implementation UBSessionView

@synthesize studentSelector = _studentSelector;
@synthesize listSelectView = _listSelectView;
@synthesize createBreach = _createBreach;
@synthesize removeStudents = _removeStudents;

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
        self.studentSelector = [[UBStudentSelectorView alloc] initWithStudents:nil];
        
        _removeStudents = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_removeStudents setTitle:@"Remove Students" forState:UIControlStateNormal];
        [_removeStudents sizeToFit];
        [self addSubview:_removeStudents];
        
        _createBreach = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_createBreach setTitle:@"New Breach" forState:UIControlStateNormal];
        [_createBreach sizeToFit];
        [self addSubview:_createBreach];
        
        self.selectorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.selectorLabel.text = @"Students in This Session";
        [self.selectorLabel sizeToFit];
        [self addSubview:self.selectorLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    if (_studentSelector) {
        _studentSelector.frame = CGRectMake(0, self.frame.size.height - 100.0f, LEFT_WIDTH, 100.0f);
    }
    if (_listSelectView) {
        _listSelectView.frame = CGRectMake(LEFT_WIDTH, 0, RIGHT_WIDTH, self.frame.size.height);
    }
    
    self.selectorLabel.frame = CGRectPosition(self.selectorLabel.frame, 0, _studentSelector.frame.origin.y - self.selectorLabel.frame.size.height - 5.0f);
    
    _createBreach.frame = CGRectPosition(_createBreach.frame, 0, self.selectorLabel.frame.origin.y - 10.0f - 44.0f);
    _removeStudents.frame = CGRectPosition(_removeStudents.frame, _createBreach.frame.size.width + 2.0f, _createBreach.frame.origin.y);
}

- (void)setListSelectView:(UIView *)listSelectView
{
    _listSelectView = listSelectView;
    [_listSelectView removeFromSuperview];
    [self addSubview:_listSelectView];
}

- (void)setStudentSelector:(UBStudentSelectorView *)studentSelector
{
    _studentSelector = studentSelector;
    [_studentSelector removeFromSuperview];
    [self addSubview:_studentSelector];
}

@end
