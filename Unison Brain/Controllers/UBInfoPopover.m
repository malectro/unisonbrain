//
//  UBInfoPopover.m
//  Unison Brain
//
//  Created by Kyle Warren on 5/23/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBInfoPopover.h"

@implementation UBInfoPopover

- (id)initWithTitle:(NSString *)title text:(NSString *)text
{
    self = [super initWithContentViewController:[[UIScrollView alloc] init]];
    if (self) {
        self.scrollView = (UIScrollView *) self.contentViewController;
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = title;
        self.titleLabel.font = [UIFont systemFontOfSize:30.0f];
        [self.scrollView addSubview:self.titleLabel];
        
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.text = text;
        self.textLabel.font = [UIFont systemFontOfSize:16.0f];
        self.textLabel.numberOfLines = 0;
        [self.scrollView addSubview:self.textLabel];
    }
    return self;
}

- (void)setPopoverContentSize:(CGSize)popoverContentSize
{
    [super setPopoverContentSize:popoverContentSize];
    
    self.scrollView.frame = CGRectMake(0, 0, popoverContentSize.width, popoverContentSize.height);
    self.titleLabel.frame = CGRectMake(5.0f, 0, self.popoverContentSize.width - 10.0f, 40.0f);
    self.textLabel.frame = CGRectMake(5.0f, 40.0f, self.titleLabel.frame.size.width, 0);
}

@end
