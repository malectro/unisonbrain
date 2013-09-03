//
//  UBContributionSearchCell.h
//  unison
//
//  Created by Joseph Posner on 9/2/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBContributionCell.h"

@interface UBContributionSearchCell : UBContributionCell

@property (nonatomic) UBContribution *contribution;
@property (nonatomic) UBSessionViewController *sessionViewController;
@property (nonatomic, readonly) UITextView *textField;
@property (nonatomic, readonly) CGFloat textHeight;


@end
