//
//  UBStudentView.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/19/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBStudentView.h"

#import "UBFunctions.h"

@interface UBStudentView ()

@property (nonatomic) UILabel *contribsLabel;

@end

@implementation UBStudentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _contribsLabel = [[UILabel alloc] init];
        _contribsLabel.text = @"";
    }
    return self;
}

- (void)layoutSubviews
{
    if (self.contributionsView != nil) {
        self.contributionsView.frame = CGRectPosition(self.frame, 0, 0);
    }
}

- (void)setContributionsView:(UITableView *)contributionsView
{
    [self addSubview:contributionsView];
    _contributionsView = contributionsView;
}

@end
