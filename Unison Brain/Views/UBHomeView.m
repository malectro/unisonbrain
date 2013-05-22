
//
//  UBHomeView.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBHomeView.h"

#import "UBColor.h"

#define kLeftSplitWidth 600.0f

@interface UBHomeView ()

@property (nonatomic) UILabel *sessionsLabel;
@property (nonatomic) UILabel *studentsLabel;
@property (nonatomic) UILabel *announcementsLabel;

@property (nonatomic) UIView *studentsBorder;
@property (nonatomic) UIView *leftSplitBorder;

@end

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
        
        _sessionsLabel = [[UILabel alloc] init];
        _sessionsLabel.text = @"Recent Sessions";
        _sessionsLabel.font = [UIFont systemFontOfSize:30.0f];
        [self addSubview:_sessionsLabel];
        
        _studentsLabel = [[UILabel alloc] init];
        _studentsLabel.text = @"Your Students";
        _studentsLabel.font = [UIFont systemFontOfSize:30.0f];
        [self addSubview:_studentsLabel];
        
        _announcementsLabel = [[UILabel alloc] init];
        _announcementsLabel.text = @"Announcements";
        _announcementsLabel.font = [UIFont systemFontOfSize:30.0f];
        [self addSubview:_announcementsLabel];
        
        _createSessionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_createSessionButton setTitle:@"Create a Session" forState:UIControlStateNormal];
        [_createSessionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_createSessionButton];
        
        _studentsBorder = [[UIView alloc] init];
        _studentsBorder.backgroundColor = [UBColor borderColor];
        [self addSubview:_studentsBorder];
        
        _leftSplitBorder = [[UIView alloc] init];
        _leftSplitBorder.backgroundColor = [UBColor borderColor];
        [self addSubview:_leftSplitBorder];
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat yHeight = 0;
    
    _teacherNameLabel.frame = CGRectZero;
    
    _sessionsLabel.frame = CGRectMake(10.0f, 0, kLeftSplitWidth - 10.0f, 40.0f);
    yHeight += _sessionsLabel.frame.size.height + _sessionsLabel.frame.origin.y;
    
    yHeight += 5.0f;
    _createSessionButton.frame = CGRectMake(10.0f, yHeight, 200.0f, 30.0f);
    yHeight += _createSessionButton.frame.size.height;
    
    if (_sessionsView != nil) {
        _sessionsView.frame = CGRectMake(0, yHeight, kLeftSplitWidth, 250.0f);
        yHeight += _sessionsView.frame.size.height;
    }
    
    _studentsBorder.frame = CGRectMake(0, yHeight, kLeftSplitWidth, 1.0f);
    _studentsLabel.frame = CGRectMake(10.0f, yHeight, kLeftSplitWidth - 10.0f, 50.0f);
    yHeight += _studentsLabel.frame.size.height;
    
    if (_studentsView != nil) {
        _studentsView.frame = CGRectMake(0, yHeight, kLeftSplitWidth, self.frame.size.height - yHeight);
        yHeight += _studentsView.frame.size.height;
    }
    
    _leftSplitBorder.frame = CGRectMake(kLeftSplitWidth, 0, 1.0f, self.frame.size.height);
    
    _announcementsLabel.frame = CGRectMake(kLeftSplitWidth + 10.0f, 0, self.frame.size.width - kLeftSplitWidth - 10.0f, 40.0f);
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
