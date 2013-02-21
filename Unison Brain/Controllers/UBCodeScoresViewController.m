//
//  UBCodeScoresViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/21/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBCodeScoresViewController.h"

#import "UBDate.h"

#import "UBStudent.h"
#import "UBCodeScore.h"
#import "UBCode.h"
#import "UBConference.h"

@interface UBCodeScoresViewController ()

@end

@implementation UBCodeScoresViewController

- (id)initWithStudent:(UBStudent *)student
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        if (student != nil) {
            _student = student;
        }
        self.modelName = @"UBCodeScore";
    }
    return self;
}

- (NSArray *)sortDescriptors
{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"conference.time" ascending:NO];
    NSSortDescriptor *sortDescriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"code.name" ascending:NO];
    NSSortDescriptor *sortDescriptor3 = [NSSortDescriptor sortDescriptorWithKey:@"code.subject.name" ascending:NO];
    return @[sortDescriptor, sortDescriptor2, sortDescriptor3];
}

- (NSPredicate *)predicate
{
    return [NSPredicate predicateWithFormat:@"conference.student = %@", self.student];
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self codeScoreAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]].code.subject.name;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    UBCodeScore *codeScore = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@ - %@", codeScore.code.name, codeScore.comment, [UBDate stringFromDateMedium:codeScore.conference.time]];
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
}

- (UBCodeScore *)codeScoreAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

@end
