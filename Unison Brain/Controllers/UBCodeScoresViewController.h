//
//  UBCodeScoresViewController.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/21/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBModelTableViewController.h"

@class UBStudent;

@interface UBCodeScoresViewController : UBModelTableViewController

@property (nonatomic) UBStudent *student;

- (id)initWithStudent:(UBStudent *)student;

@end
