//
//  UBContributionCell.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/6/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UBContribution;

@interface UBContributionCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic) UBContribution *contribution;
@property (nonatomic, readonly) UITextField *textField;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
