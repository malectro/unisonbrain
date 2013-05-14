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
        // hi
    }
    return self;
}

@end
