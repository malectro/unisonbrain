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

@interface UBStudentView ()

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
        
        _commentsLabel = [[UILabel alloc] init];
        _commentsLabel.text = @"Recent Conferences";
        _commentsLabel.font = [UIFont systemFontOfSize:28.0f];
        [_commentsLabel sizeToFit];
        [self addSubview:_commentsLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat yValue = 0;
    
    yValue = _contribsLabel.frame.size.height + _contribsLabel.frame.origin.y + 10.0f;
    
    _contribsLabel.frame = CGRectPosition(_contribsLabel.frame, 10.0f, 10.0f);
    
    if (self.contributionsView != nil) {
        self.contributionsView.frame = CGRectMake(0, yValue, kLeftColumnWidth, self.frame.size.height - yValue - kBottomSplitHeight);
    }
    
    _codesLabel.frame = CGRectPosition(_codesLabel.frame, kLeftColumnWidth + 10.0f, 10.0f);
    
    if (self.codesView != nil) {
        self.codesView.frame = CGRectMake(kLeftColumnWidth, yValue, self.frame.size.width - kLeftColumnWidth, self.frame.size.height - yValue - kBottomSplitHeight);
    }
    
    _commentsLabel.frame = CGRectPosition(_commentsLabel.frame, 10.0f, self.frame.size.height - kBottomSplitHeight + 10.0f);
    
    if (self.commentsView != nil) {
        _commentsView.frame = CGRectMake(0, _commentsLabel.frame.origin.y + _commentsLabel.frame.size.height, self.frame.size.width, kBottomSplitHeight - _commentsLabel.frame.size.height);
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

- (void)setCommentsView:(UIView *)commentsView
{
    if (_commentsView) {
        [_commentsView removeFromSuperview];
    }
    
    _commentsView = commentsView;
    [self addSubview:commentsView];
}

@end
