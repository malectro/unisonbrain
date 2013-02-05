//
//  UBSessionView.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBSessionView.h"

#define LEFT_WIDTH 770.0f
#define RIGHT_WIDTH (1024.0f - 770.0f)

@implementation UBSessionView

@synthesize studentSelector = _studentSelector;
@synthesize listSelectView = _listSelectView;

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
