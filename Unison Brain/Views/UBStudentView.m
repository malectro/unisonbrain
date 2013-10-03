//
//  UBStudentView.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/19/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBStudentView.h"

#import <QuartzCore/QuartzCore.h>

#import "UBFunctions.h"
#import "UBShadowView.h"

#define kLeftColumnWidth 400.0f
#define kBottomSplitHeight 300.0f

@interface UBStudentView () {
    UIView *_bottomSplit;
    UIView *_bottomSplitBg;
    UIView *_leftSplit;
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
        _leftSplit = [[UBShadowView alloc] init];
        [self addSubview:_leftSplit];
        
        _bottomSplit = [[UIView alloc] init];
        [self addSubview:_bottomSplit];
        
        _contribsLabel = [[UILabel alloc] init];
        _contribsLabel.text = @"Recent Contributions";
        _contribsLabel.font = [UIFont systemFontOfSize:28.0f];
        [_contribsLabel sizeToFit];
        [_leftSplit addSubview:_contribsLabel];
        
        _codesLabel = [[UILabel alloc] init];
        _codesLabel.text = @"Code Progress";
        _codesLabel.font = [UIFont systemFontOfSize:25.0f];
        [_codesLabel sizeToFit];
        [self addSubview:_codesLabel];
        
        _bottomSplitBg = [[UIView alloc] init];
        _bottomSplitBg.layer.shadowColor = [UIColor blackColor].CGColor;
        _bottomSplitBg.backgroundColor = [UIColor whiteColor];
        _bottomSplitBg.layer.shadowRadius = 10.0f;
        _bottomSplitBg.layer.shadowOpacity = 0.3f;
        _bottomSplitBg.layer.shouldRasterize = YES;
        [_bottomSplit addSubview:_bottomSplitBg];
        
        _commentsLabel = [[UILabel alloc] init];
        _commentsLabel.text = @"Conferences";
        _commentsLabel.backgroundColor = [UIColor clearColor];
        _commentsLabel.font = [UIFont systemFontOfSize:25.0f];
        [_commentsLabel sizeToFit];
        [_bottomSplit addSubview:_commentsLabel];
        
        UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didDragCommentsLabel:)];
        [_bottomSplit addGestureRecognizer:gesture];
        
        _createConference = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_createConference setTitle:@"New" forState:UIControlStateNormal];
        _createConference.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _createConference.backgroundColor = [UIColor clearColor];
        
        //_createConference.frame = CGRectMake(_createConference.frame.origin.x, _createConference.frame.origin.y, 40.0f, _createConference.frame.size.height);
        //_createConference.titleEdgeInsets = UIEdgeInsetsMake(2.0f, 3.0f, <#CGFloat bottom#>, <#CGFloat right#>)
        //_createConference.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        
        [_createConference sizeToFit];
        [_bottomSplit addSubview:_createConference];
        
        _editConference = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_editConference setTitle:@"Edit" forState:UIControlStateNormal];
        _editConference.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _editConference.backgroundColor = [UIColor clearColor];
        [_editConference sizeToFit];
        [_bottomSplit addSubview:_editConference];
        
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
    
    [self bringSubviewToFront:_leftSplit];
    [self bringSubviewToFront:_bottomSplit];
    
    yValue = _contribsLabel.frame.size.height + _contribsLabel.frame.origin.y + 10.0f;
    
    _leftSplit.frame = CGRectMake(0, 0, kLeftColumnWidth, self.frame.size.height - _bottomSplitHeight);
    
    _contribsLabel.frame = CGRectPosition(_contribsLabel.frame, 10.0f, 10.0f);
    
    if (self.contributionsView != nil) {
        self.contributionsView.frame = CGRectMake(0, yValue, kLeftColumnWidth, self.frame.size.height - yValue - _bottomSplitHeight);
    }
    
    _codesLabel.frame = CGRectPosition(_codesLabel.frame, kLeftColumnWidth + 10.0f, 10.0f);
    
    if (self.codesView != nil) {
        self.codesView.frame = CGRectMake(kLeftColumnWidth, yValue, self.frame.size.width - kLeftColumnWidth, self.frame.size.height - yValue - _bottomSplitHeight);
    }
    
    _bottomSplit.frame = CGRectMake(0, self.frame.size.height - _bottomSplitHeight, self.frame.size.width, _bottomSplitHeight);
    _bottomSplitBg.frame = CGRectPosition(_bottomSplit.frame, 0, 0);
    
    _commentsLabel.frame = CGRectPosition(_commentsLabel.frame, 10.0f, 12.0f);
    
    _createConference.frame = CGRectMake(_commentsLabel.frame.origin.x + _commentsLabel.frame.size.width + 10.0f, _commentsLabel.frame.origin.y + 1.0f, _createConference.frame.size.width, 30.0f);
    
    _editConference.frame = CGRectMake(_commentsLabel.frame.origin.x + _commentsLabel.frame.size.width + _createConference.frame.size.width + 15.0f, _commentsLabel.frame.origin.y + 1.0f, _editConference.frame.size.width, 30.0f);

    
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
    
    //zero check!
    int splitNewY = self.frame.size.height - _bottomSplitHeight;
    if (splitNewY<0) {
        splitNewY = 0;
        _bottomSplitHeight = self.frame.size.height;
    }
    
    _bottomSplit.frame = CGRectMake(0, splitNewY, self.frame.size.width, _bottomSplitHeight);
    
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
    [_leftSplit addSubview:contributionsView];
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
