//
//  UBStudentView.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/19/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBStudentView.h"

#import "UBFunctions.h"

#define kLeftColumnWidth 400.0f
#define kBottomSplitHeight 300.0f

@interface UBStudentView () {
    UIView *_bottomSplit;
    CGFloat _prevBottomSplitHeight;
    CGFloat _bottomSplitHeight;
}

@property (nonatomic) UILabel *contribsLabel;
@property (nonatomic) UILabel *codesLabel;
@property (nonatomic) UILabel *commentsLabel;

@end

@implementation UBStudentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _contribsLabel = [[UILabel alloc] init];
        _contribsLabel.text = @"Recent Contributions";
        _contribsLabel.font = [UIFont systemFontOfSize:28.0f];
        [_contribsLabel sizeToFit];
        [self addSubview:_contribsLabel];
        
        _codesLabel = [[UILabel alloc] init];
        _codesLabel.text = @"Code Progress";
        _codesLabel.font = [UIFont systemFontOfSize:28.0f];
        [_codesLabel sizeToFit];
        [self addSubview:_codesLabel];
        
        _bottomSplit = [[UIView alloc] init];
        [self addSubview:_bottomSplit];
        
        _commentsLabel = [[UILabel alloc] init];
        _commentsLabel.text = @"Conferences";
        _commentsLabel.font = [UIFont systemFontOfSize:28.0f];
        [_commentsLabel sizeToFit];
        [_bottomSplit addSubview:_commentsLabel];
        
        UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didDragCommentsLabel:)];
        [_bottomSplit addGestureRecognizer:gesture];
        
        _createConference = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_createConference setTitle:@"New" forState:UIControlStateNormal];
        //_createConference.titleEdgeInsets = UIEdgeInsetsMake(2.0f, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
        //_createConference.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [_createConference sizeToFit];
        [_bottomSplit addSubview:_createConference];
        
        _conferenceMetaView = [[UIScrollView alloc] init];
        _conferenceMetaView.pagingEnabled = YES;
        _conferenceMetaView.directionalLockEnabled = YES;
        _conferenceMetaView.showsHorizontalScrollIndicator = NO;
        [_bottomSplit addSubview:_conferenceMetaView];
        
        _prevBottomSplitHeight = kBottomSplitHeight;
        _bottomSplitHeight = kBottomSplitHeight;
        [self bringSubviewToFront:_bottomSplit];
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat yValue = 0;
    
    yValue = _contribsLabel.frame.size.height + _contribsLabel.frame.origin.y + 10.0f;
    
    _contribsLabel.frame = CGRectPosition(_contribsLabel.frame, 10.0f, 10.0f);
    
    if (self.contributionsView != nil) {
        self.contributionsView.frame = CGRectMake(0, yValue, kLeftColumnWidth, self.frame.size.height - yValue - _bottomSplitHeight);
    }
    
    _codesLabel.frame = CGRectPosition(_codesLabel.frame, kLeftColumnWidth + 10.0f, 10.0f);
    
    if (self.codesView != nil) {
        self.codesView.frame = CGRectMake(kLeftColumnWidth, yValue, self.frame.size.width - kLeftColumnWidth, self.frame.size.height - yValue - _bottomSplitHeight);
    }
    
    _bottomSplit.frame = CGRectMake(0, self.frame.size.height - _bottomSplitHeight, self.frame.size.width, _bottomSplitHeight);
    
    _commentsLabel.frame = CGRectPosition(_commentsLabel.frame, 10.0f, 0);
    _createConference.frame = CGRectMake(_commentsLabel.frame.origin.x + _commentsLabel.frame.size.width + 10.0f, _commentsLabel.frame.origin.y, _commentsLabel.frame.size.width, 30.0f);
    
    _conferenceMetaView.frame = CGRectMake(0, _commentsLabel.frame.origin.y + _commentsLabel.frame.size.height, _bottomSplit.frame.size.width, _bottomSplitHeight - _commentsLabel.frame.size.height);
    
    if (self.conferencesView != nil) {
        self.conferencesView.frame = CGRectPosition(_conferenceMetaView.frame, 0, 0);
    }
    
    if (self.conferenceView != nil) {
        self.conferenceView.frame = CGRectPosition(_conferenceMetaView.frame, _conferenceMetaView.frame.size.width, 0);
    }
    
    _conferenceMetaView.contentSize = CGSizeMake(_conferenceMetaView.frame.size.width * 2, _conferenceMetaView.frame.size.height);
}

- (void)didDragCommentsLabel:(UIPanGestureRecognizer *)gesture
{
    _bottomSplitHeight = _prevBottomSplitHeight - [gesture translationInView:self].y;
    _bottomSplit.frame = CGRectMake(0, self.frame.size.height - _bottomSplitHeight, self.frame.size.width, _bottomSplitHeight);
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        _prevBottomSplitHeight = _bottomSplitHeight;
    }
}

- (void)setContributionsView:(UITableView *)contributionsView
{
    if (_contributionsView) {
        [_contributionsView removeFromSuperview];
    }
    
    _contributionsView = contributionsView;
    [self addSubview:contributionsView];
}

- (void)setCodesView:(UIView *)codesView
{
    if (_codesView) {
        [_codesView removeFromSuperview];
    }
    
    _codesView = codesView;
    [self addSubview:codesView];
}

- (void)setConferencesView:(UIView *)conferencesView
{
    if (_conferencesView) {
        [_conferencesView removeFromSuperview];
    }
    
    _conferencesView = conferencesView;
    [_conferenceMetaView addSubview:conferencesView];
}

- (void)setConferenceView:(UIView *)conferenceView
{
    if (_conferenceView) {
        [_conferenceView removeFromSuperview];
    }
    
    _conferenceView = conferenceView;
    [_conferenceMetaView addSubview:conferenceView];
}

- (void)showConferencesView
{
    [self.conferenceMetaView scrollRectToVisible:self.conferencesView.frame animated:YES];
}

- (void)showConferenceView
{
    [self.conferenceMetaView scrollRectToVisible:self.conferenceView.frame animated:YES];
}

@end
