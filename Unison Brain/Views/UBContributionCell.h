//
//  UBContributionCell.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/6/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UBContributionCell : UITableViewCell

@property (nonatomic, readonly) UITextField *textField;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
