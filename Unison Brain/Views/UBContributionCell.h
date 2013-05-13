//
//  UBContributionCell.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/6/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UBContribution;
@class UBSessionViewController;

@interface UBContributionCell : UITableViewCell<UITextViewDelegate>

@property (nonatomic) UBContribution *contribution;
@property (nonatomic) UBSessionViewController *sessionViewController;
@property (nonatomic, readonly) UITextView *textField;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
