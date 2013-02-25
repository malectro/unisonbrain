//
//  UBConferencesViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/25/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBConferencesViewController.h"

#import "UBDate.h"

#import "UBConference.h"

@interface UBConferencesViewController ()

@end

@implementation UBConferencesViewController

- (id)initWithStudent:(UBStudent *)student
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        if (student != nil) {
            _student = student;
        }
        
        self.modelName = @"UBConference";
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
    return [NSPredicate predicateWithFormat:@"student = %@", self.student];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    UBConference *conf = [self conferenceAtIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [UBDate stringFromDateMedium:conf.time], conf.notes];
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
}

- (UBConference *)conferenceAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}


@end
