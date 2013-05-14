//
//  UBSelectPopover.m
//  Unison Brain
//
//  Created by Kyle Warren on 5/13/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBSelectPopover.h"

#import "UBArrayTableViewController.h"

@implementation UBSelectPopover

- (id)initWithItems:(NSArray *)items
{
    
    self = [super initWithContentViewController:[[UBArrayTableViewController alloc] initWithItems:items]];
    if (self) {
        self.tableController = (UBArrayTableViewController *) self.contentViewController;
    }
    return self;
}

- (void)addTarget:(id)target action:(SEL)action
{
    [self.tableController addTarget:target action:action];
}

- (NSInteger)selectedIndex
{
    return self.tableController.lastSelectedIndex;
}

@end
