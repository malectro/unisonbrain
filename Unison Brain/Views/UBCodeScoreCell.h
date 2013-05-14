//
//  UBCodeScoreCell.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/26/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UBCodeScore;
@class UBConferenceCommentViewController;

@interface UBCodeScoreCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic) UBCodeScore *codeScore;
@property (nonatomic, readonly) UITextField *textField;
@property (nonatomic, readonly) UISegmentedControl *scoreControl;
@property (nonatomic, readonly) UILabel *codeName;
@property (nonatomic, readonly) UILabel *notionLabel;
@property (nonatomic, readonly) UIPickerView *notionPicker;
@property (nonatomic) UBConferenceCommentViewController *conferenceController;

- (id)initWithReuseIdentifier:(NSString *)identifier;

@end
