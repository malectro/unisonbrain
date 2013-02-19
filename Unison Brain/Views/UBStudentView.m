//
//  UBStudentView.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/19/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBStudentView.h"

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
    if (self.breachesView) {
        self.breachesView.frame = self.frame;
    }
}

@end
