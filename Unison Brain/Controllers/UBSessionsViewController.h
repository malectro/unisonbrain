//
//  UBSessionsViewController.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UBTeacher;

@interface UBSessionsViewController : UITableViewController<NSFetchedResultsControllerDelegate>

- (id)initWithTeacher:(UBTeacher *)teacher;

@end
