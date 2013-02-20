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
            _person = person;
        }
        self.modelName = @"UBContribution";
    }
    return self;
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

#pragma mark - Table view data source

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    UBContribution *contribution = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [UBDate stringFromDateMedium:contribution.time], contribution.text];
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
}

@end
