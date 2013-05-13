//
//  UBContributionCell.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/6/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBContributionCell.h"

#import "UBContribution.h"
#import "UBSessionViewController.h"
#import "UBPerson.h"

@implementation UBContributionCell

@synthesize textHeight = _textHeight;

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
        //_textField.placeholder = @"Contribution...";
        _textField.delegate = self;
        
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
    
    //self.backgroundView.frame = CGRectMake(10.0f, 0, self.frame.size.width - 20.0f, self.frame.size.height);
    self.textLabel.frame = CGRectMake(10.0f, 10.0f, 190.0f, 20.0f);
    
    CGFloat textFieldWidth = [self textWidth];
    _textField.frame = CGRectMake(200.0f, 10.0f, textFieldWidth, [self textHeight]);
}

- (void)setContribution:(UBContribution *)contribution
{
    _textField.text = contribution.text;
    self.textLabel.text = contribution.person.fname;
    _contribution = contribution;
}

- (void)textViewDidEndEditing:(UITextView *)textField
{
    self.contribution.text = textField.text;
    // probably should save here but not sync.
    
    if (self.sessionViewController != nil) {
        [self.sessionViewController editedContribution:self];
    }
}

- (BOOL)textViewShouldReturn:(UITextView *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat oldTextHeight = self.textHeight;
    _textHeight = 0.0f;
    
    if (oldTextHeight != self.textHeight) {
        [self.sessionViewController editedContribution:self];
    }
}

- (CGFloat)textWidth
{
    return self.frame.size.width - 200.0f - 55.0f;
}

- (CGFloat)textHeight
{
    if (_textHeight == 0.0f) {
        _textHeight = [self.textField.text  sizeWithFont:_textField.font constrainedToSize:CGSizeMake([self textWidth], 10000.0f) lineBreakMode:NSLineBreakByWordWrapping].height;
    }
    return _textHeight;
}

@end
