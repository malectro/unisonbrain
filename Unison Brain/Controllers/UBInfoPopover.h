//
//  UBInfoPopover.h
//  Unison Brain
//
//  Created by Kyle Warren on 5/23/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UBInfoPopover : UIPopoverController

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UILabel *textLabel;
@property (nonatomic) UILabel *titleLabel;

- (id)initWithTitle:(NSString *)title text:(NSString *)text;

@end
