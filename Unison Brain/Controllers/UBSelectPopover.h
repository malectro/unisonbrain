//
//  UBSelectPopover.h
//  Unison Brain
//
//  Created by Kyle Warren on 5/13/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UBArrayTableViewController;

@interface UBSelectPopover : UIPopoverController

@property (nonatomic) UBArrayTableViewController *tableController;
@property (nonatomic) NSInteger selectedIndex;

- (id)initWithItems:(NSArray *)items;

- (void)addTarget:(id)target action:(SEL)action;

@end
