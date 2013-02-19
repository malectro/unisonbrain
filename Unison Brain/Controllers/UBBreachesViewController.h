//
//  UBBreachesViewController.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/19/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBModelTableViewController.h"

#import "UBPerson.h"

@interface UBBreachesViewController : UBModelTableViewController

@property (nonatomic) UBPerson *person;

- (id)initWithPerson:(UBPerson *)person;

@end
