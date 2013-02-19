//
//  UBSessionsViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBSessionsViewController.h"

#import "UBDate.h"

#import "UBSession.h"
#import "UBTeacher.h"
#import "UBAppDelegate.h"

#import "UBSessionViewController.h"

@interface UBSessionsViewController ()

@property UBTeacher *teacher;

@end

@implementation UBSessionsViewController

- (id)initWithTeacher:(UBTeacher *)teacher
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.teacher = teacher;
        self.modelName = @"UBSession";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)sortDescriptors
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:NO];
    return @[sortDescriptor];
}

- (NSPredicate *)predicate
{
    return [NSPredicate predicateWithFormat:@"ANY people == %@", self.teacher];
}

#pragma mark - Table view data source

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    UBSession *session = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", session.studentList, [UBDate stringFromDateMedium:session.time]];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UBSession *session = [self.fetchedResultsController objectAtIndexPath:indexPath];
    UBSessionViewController *sessionViewController = [[UBSessionViewController alloc] initWithSession:session];
    [self.navigationController pushViewController:sessionViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // REMOVE THE SESSION at indexPath
        UBModel *modelToDestroy = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [modelToDestroy destroy];
    }
    
}

@end
