//
//  UBStudentView.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/19/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBStudentView.h"

#import "UBFunctions.h"

@implementation UBStudentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    if (self.breachesView != nil) {
        self.breachesView.frame = CGRectPosition(self.frame, 0, 0);
    }
}

- (void)setBreachesView:(UITableView *)breachesView
{
    [self addSubview:breachesView];
    _breachesView = breachesView;
}

@end
