
//
//  UBHomeView.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBHomeView.h"

@implementation UBHomeView

@synthesize teacherNameLabel = _teacherNameLabel,
            createSessionButton = _createSessionButton,
            sessionsView = _sessionsView,
            studentsView = _studentsView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _teacherNameLabel = [[UILabel alloc] init];
        [self addSubview:_teacherNameLabel];
        
        _createSessionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_createSessionButton setTitle:@"Create a Session" forState:UIControlStateNormal];
        [_createSessionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_createSessionButton];
    }
    return self;
}

- (void)layoutSubviews
{
    _teacherNameLabel.frame = CGRectMake(0, 0, self.frame.size.width, 20.0f);
    _createSessionButton.frame = CGRectMake(0, 30.0f, 200.0f, 30.0f);
    
    if (_sessionsView != nil) {
        _sessionsView.frame = CGRectMake(0, 60.0f, 600.0f, 300.0f);
    }
    
    if (_studentsView != nil) {
        _studentsView.frame = CGRectMake(0, 360.0f, 600.0f, 300.0f);
    }

}

- (void)setSessionsView:(UITableView *)sessionsView
{
    if (_sessionsView != nil) {
        [_sessionsView removeFromSuperview];
    }
    
    [self addSubview:sessionsView];
    _sessionsView = sessionsView;
}

- (void)setStudentsView:(UITableView *)studentsView
{
    if (_studentsView != nil) {
        [_studentsView removeFromSuperview];
    }
    
    [self addSubview:studentsView];
    _studentsView = studentsView;
}



@end
