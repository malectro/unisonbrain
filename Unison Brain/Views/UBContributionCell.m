//
//  UBContributionCell.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/6/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBContributionCell.h"

@implementation UBContributionCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"Contribution...";
        [self addSubview:_textField];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.frame = CGRectMake(0, 0, 200.0f, 20.0f);
    _textField.frame = CGRectMake(200.0f, 0, self.frame.size.width - 200.0f, 20.0f);
}

@end
