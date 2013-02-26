//
//  UBModelTableViewController.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/19/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UBModelTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) NSString *modelName;
@property (nonatomic, readonly) NSPredicate *predicate;

// If you do NOT override this, changing the predicate won't do anything once the results are cached.
@property (nonatomic, readonly) NSString *cacheName;

// override the following methods
- (NSArray *)sortDescriptors;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)allocCell:(NSString *)identifer;

- (void)addRowSelectionTarget:(id)target action:(SEL)action;

@end
