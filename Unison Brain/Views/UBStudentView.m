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

@interface UBStudentView ()

@property (nonatomic) UILabel *contribsLabel;
@property (nonatomic) UILabel *codesLabel;

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
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat yValue = 0;
    
    yValue = _contribsLabel.frame.size.height + _contribsLabel.frame.origin.y + 10.0f;
    
    _contribsLabel.frame = CGRectPosition(_contribsLabel.frame, 10.0f, 10.0f);
    
    if (self.contributionsView != nil) {
        self.contributionsView.frame = CGRectMake(0, yValue, kLeftColumnWidth, self.frame.size.height - yValue);
    }
    
    _codesLabel.frame = CGRectPosition(_codesLabel.frame, kLeftColumnWidth + 10.0f, 10.0f);
    
    if (self.codesView != nil) {
        self.codesView.frame = CGRectMake(kLeftColumnWidth, yValue, self.frame.size.width - kLeftColumnWidth, self.frame.size.height - yValue);
    }
}

- (void)setContributionsView:(UITableView *)contributionsView
{
    [self addSubview:contributionsView];
    _contributionsView = contributionsView;
}

@end
