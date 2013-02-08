//
//  UBBreachHeaderView.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/8/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBBreachHeaderView.h"

#import <QuartzCore/QuartzCore.h>

#import "UBDate.h"

#import "UBBreach.h"

@implementation UBBreachHeaderView

- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor whiteColor];
        _backgroundView.opaque = YES;
        //[self addSubview:_backgroundView];
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:_textLabel];
        
        self.selected = NO;
    }
    return self;
}

- (void)layoutSubviews
{
    _backgroundView.frame = CGRectMake(10.0f, 20.0f, self.frame.size.width - 20.0f, self.frame.size.height - 20.0f);
    _textLabel.frame = CGRectMake(50.0f, 0.0f, self.frame.size.width - 100.0f, self.frame.size.height - 0.0f);
}

- (void)setBreach:(UBBreach *)breach
{
    _breach = breach;
    self.textLabel.text = [NSString stringWithFormat:@"Breach with %@ - %@", breach.studentList, [UBDate stringFromDateMedium:breach.time]];
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    
    if (_selected) {
        _textLabel.textColor = [UIColor darkTextColor];
    }
    else {
        _textLabel.textColor = [UIColor grayColor];
    }
}

@end
