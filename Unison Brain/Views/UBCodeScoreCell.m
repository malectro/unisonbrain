//
//  UBCodeScoreCell.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/26/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBCodeScoreCell.h"

#import "UBCodeScore.h"
#import "UBCode.h"
#import "UBSelectPopover.h"
#import "UBConferenceCommentViewController.h"

@implementation UBCodeScoreCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
                
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"Write a comment...";
        _textField.delegate = self;
        [self addSubview:_textField];
        
                                                   
        _scoreControl = [[UISegmentedControl alloc] initWithItems:@[@"1",@"2",@"3",@"4"]];        
        
        [_scoreControl addTarget:self action:@selector(changedScore) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_scoreControl];
        
        _codeName = [[UILabel alloc] init];
        _codeName.text = @"<No Code>";
        [self addSubview:_codeName];
        
        _notionLabel = [[UILabel alloc] init];
        _notionLabel.text = @"<No Type>";
        _notionLabel.userInteractionEnabled = YES;
        [_notionLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedNotion)]];
        [self addSubview:_notionLabel];
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
    _textField.frame = CGRectMake(10.0f, 10.0f, self.frame.size.width - 400.0f, 20.0f);
    _codeName.frame = CGRectMake(_textField.frame.size.width + 10.0f, 10.0f, 100.0f, 20.0f);
    self.notionLabel.frame = CGRectMake(_codeName.frame.size.width + _codeName.frame.origin.x, 10.0f, 100.0f, 20.0f);
    self.scoreControl.frame = CGRectMake(self.frame.size.width - 190.0f, 6.0f, 180.f, 24.0f);
}

- (void)setCodeScore:(UBCodeScore *)codeScore
{
    _codeScore = codeScore;
    self.textField.text = codeScore.comment;
    
    if (codeScore.score) {
        [self.scoreControl setSelectedSegmentIndex:codeScore.score.integerValue - 1];
    }
    
    if (codeScore.notion) {
        self.notionLabel.text = codeScore.notion;
    } else {
        self.notionLabel.text = @"<No Type>";
    }
    
    if (codeScore.code) {
        self.codeName.text = codeScore.code.name;
    }
    else {
        self.codeName.text = @"<No Code>";;
    }
}

- (void)changedScore
{
    self.codeScore.score = [NSNumber numberWithInteger:_scoreControl.selectedSegmentIndex + 1];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField:(UITextField *)theComment
{
    self.codeScore.comment = theComment.text;
}


- (void)textFieldDidEndEditing:(UITextField *)textField:(UITextField *)theComment
{
    self.codeScore.comment = theComment.text;

}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchedNotion
{
    if (self.conferenceController != nil) {
        [self.conferenceController touchedNotionForCodeScore:self];
    }
}

@end
