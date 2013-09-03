//
//  UBContributionSearchCell.m
//  unison
//
//  Created by Joseph Posner on 9/2/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBContributionSearchCell.h"

@implementation UBContributionSearchCell

@synthesize textHeight = _textHeight;
@synthesize textField = _textField;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _textField = [[UITextView alloc] init];
        _textField.editable = YES;
        _textField.backgroundColor = [UIColor clearColor];
        _textField.font = [UIFont systemFontOfSize:14.0f];
        _textField.contentInset = UIEdgeInsetsMake(-7.0f, -7.0f, -7.0f, -7.0f);
        [_textField setReturnKeyType:UIReturnKeyDone];
        //_textField.placeholder = @"Contribution...";
        _textField.delegate = self;
        
        [self addSubview:_textField];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //self.backgroundView.frame = CGRectMake(10.0f, 0, self.frame.size.width - 20.0f, self.frame.size.height);
    self.textLabel.frame = CGRectMake(10.0f, 10.0f, 190.0f, 20.0f);
    
    CGFloat textFieldWidth = [self textWidth];
    _textField.frame = CGRectMake(200.0f, 10.0f, textFieldWidth, [self textHeight]);
}

- (CGFloat)textWidth
{
    return self.frame.size.width - self.textLabel.frame.size.width - 40.0f;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
