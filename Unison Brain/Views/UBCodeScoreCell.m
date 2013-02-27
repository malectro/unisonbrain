//
//  UBCodeScoreCell.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/26/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBCodeScoreCell.h"

#import "UBCodeScore.h"

@implementation UBCodeScoreCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        _textField = [[UITextField alloc] init];
        [self addSubview:_textField];
        
        _scoreControl = [[UISegmentedControl alloc] initWithItems:@[@"1", @"2", @"3", @"4"]];
        [self addSubview:_scoreControl];
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
    _textField.frame = CGRectMake(10.0f, 10.0f, self.frame.size.width - 200.0f, 20.0f);
    self.scoreControl.frame = CGRectMake(_textField.frame.size.width + 10.0f, 10.0f, 190.f, 20.0f);
}

- (void)setCodeScore:(UBCodeScore *)codeScore
{
    _codeScore = codeScore;
    self.textField.text = codeScore.comment;
    
    if (codeScore.score) {
        [self.scoreControl setSelectedSegmentIndex:codeScore.score.integerValue - 1];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.codeScore.comment = textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
