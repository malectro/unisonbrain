//
//  UBShadowView.m
//  Unison Brain
//
//  Created by Kyle Warren on 5/22/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBShadowView.h"

#import "UBFunctions.h"

@implementation UBShadowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bg = [[UIView alloc] init];
        self.bg.layer.shadowColor = [UIColor blackColor].CGColor;
        self.bg.layer.shadowOpacity = 0.5f;
        self.bg.layer.shadowRadius = 10.0f;
        self.bg.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bg];
    }
    return self;
}

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews
{
    self.bg.frame = CGRectPosition(self.frame, 0, 0);
}

@end
