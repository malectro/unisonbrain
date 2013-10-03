//
//  UBConferencesViewController.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/25/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBModelTableViewController.h"
#import "UBUser.h"

@class UBStudent;

@interface UBConferencesViewController : UBModelTableViewController

@property (nonatomic) UBStudent *student;


- (id)initWithStudent:(UBStudent *)student;

@end
