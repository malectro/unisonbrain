//
//  UBArrayTableViewController.h
//  Unison Brain
//
//  Created by Kyle Warren on 5/13/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UBArrayTableViewController : UITableViewController

@property (nonatomic) NSArray *items;
@property (nonatomic) NSInteger lastSelectedIndex;

- (id)initWithItems:(NSArray *)items;

- (void)addTarget:(id)target action:(SEL)action;

@end
