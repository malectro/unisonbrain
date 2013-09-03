//
//  UBContributionsViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/19/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBContributionsViewController.h"

#import "UBContribution.h"

#import "UBDate.h"

@interface UBContributionsViewController ()

@end

@implementation UBContributionsViewController

- (id)initWithPerson:(UBPerson *)person
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        if (person != nil) {
            self.person = person;
        }
        
        self.modelName = @"UBContribution";
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:@"UBContribution:fetchAll" object:nil];
    }
    return self;
}



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSArray *)sortDescriptors
{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:NO];
    return @[sortDescriptor];
}

- (NSPredicate *)predicate
{
    return [NSPredicate predicateWithFormat:@"person = %@", self.person];
}

- (void)setPerson:(UBPerson *)person
{
    _person = person;
    [self.person fetchContributions];
}

#pragma mark - Table view data source

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    UBContribution *contribution = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [UBDate stringFromDateMedium:contribution.time], contribution.text];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

@end
