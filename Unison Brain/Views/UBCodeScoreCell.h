//
//  UBCodeScoreCell.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/26/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UBCodeScore;

@interface UBCodeScoreCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic) UBCodeScore *codeScore;
@property (nonatomic, readonly) UITextField *textField;
@property (nonatomic, readonly) UISegmentedControl *scoreControl;

- (id)initWithReuseIdentifier:(NSString *)identifier;

@end
