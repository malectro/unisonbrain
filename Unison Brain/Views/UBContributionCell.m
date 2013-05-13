//
//  UBContributionCell.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/6/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBContributionCell.h"

#import "UBContribution.h"
#import "UBPerson.h"

@implementation UBContributionCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _textField = [[UITextView alloc] init];
        _textField.editable = YES;
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
    _textField.frame = CGRectMake(200.0f, 10.0f, self.frame.size.width - 200.0f, 20.0f);
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
}

- (BOOL)textViewShouldReturn:(UITextView *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
