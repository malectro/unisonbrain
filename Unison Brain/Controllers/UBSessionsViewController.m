//
//  UBSessionsViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBSessionsViewController.h"

#import "UBSession.h"
#import "UBTeacher.h"
#import "UBAppDelegate.h"

@interface UBSessionsViewController ()

@property UBTeacher *teacher;
@property NSFetchedResultsController *fetchedResultsController;

@end

@implementation UBSessionsViewController

@synthesize fetchedResultsController = _fetchedResultsController;

- (id)initWithTeacher:(UBTeacher *)teacher
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.teacher = teacher;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController == nil) {
        UBAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"UBSession" inManagedObjectContext:appDelegate.managedObjectContext];
        
        fetchRequest.entity = entity;
        fetchRequest.fetchBatchSize = 40;
        fetchRequest.sortDescriptors = [self sortDescriptors];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:appDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:@"UB"];
        _fetchedResultsController.delegate = self;
        
        NSError *error = nil;
        if (![_fetchedResultsController performFetch:&error]) {
            NSLog(@"Error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
    return _fetchedResultsController;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UBSession *session = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = session.isCoded.stringValue;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
