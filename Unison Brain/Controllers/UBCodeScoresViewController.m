//
//  UBCodeScoresViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/21/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBCodeScoresViewController.h"
#import "UBCodeViewController.h"

#import "UBDate.h"
#import "UBStudent.h"
#import "UBCodeScore.h"
#import "UBCode.h"
#import "UBConference.h"

@interface UBCodeScoresViewController ()

@property (nonatomic) NSArray *subjects;
@property (nonatomic) NSArray *groupedCodeScores;

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
        self.subjects = [[UBSubject all] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO]]];
    }
    return self;
}

- (NSArray *)sortDescriptors
{
    NSSortDescriptor *sortDescriptor3 = [NSSortDescriptor sortDescriptorWithKey:@"conference.time" ascending:NO];
    NSSortDescriptor *sortDescriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"code.name" ascending:NO];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"code.subject.name" ascending:NO];
    return @[sortDescriptor, sortDescriptor2, sortDescriptor3];
}

- (NSPredicate *)predicate
{
    return [NSPredicate predicateWithFormat:@"conference.student = %@", self.student];
}

- (void)setSubject:(UBSubject *)subject
{
    _subject = subject;
    
    if (_subject != nil) {
        self.subjects = @[_subject];
    } else {
        self.subjects = [[UBSubject all] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO]]];
    }
    
    _groupedCodeScores = nil;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self subjectForSection:section].name;
    return [self codeScoreAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]].code.subject.name;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.subjects.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self subjectForSection:section].codes.count;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    UBCodeScore *codeScore = [self codeScoreAtIndexPath:indexPath];
    UBCode *code = [self codeForIndexPath:indexPath];
    
    if (codeScore) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@ - %@ - %@", code.name, codeScore.score, codeScore.comment, [UBDate stringFromDateMedium:codeScore.conference.time]];
    }
    else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - No score", code.name];
    }

    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
}

- (UBSubject *)subjectForSection:(NSInteger)section
{
    return self.subjects[section];
}

- (UBCode *)codeForIndexPath:(NSIndexPath *)indexPath
{
    return [self subjectForSection:indexPath.section].sortedCodes[indexPath.row];
}

- (UBCodeScore *)codeScoreAtIndexPath:(NSIndexPath *)indexPath
{
    UBCodeScore *codeScore = self.groupedCodeScores[indexPath.section][indexPath.row];
    
    if (codeScore == (id) [NSNull null]) {
        NSInteger index = [self.fetchedResultsController.fetchedObjects indexOfObjectPassingTest:^BOOL(UBCodeScore *obj, NSUInteger idx, BOOL *stop) {
            return obj.code == [self codeForIndexPath:indexPath];
        }];
        
        if (index != NSNotFound) {
            codeScore = self.fetchedResultsController.fetchedObjects[index];
            self.groupedCodeScores[indexPath.section][indexPath.row] = codeScore;
        }
        else {
            codeScore = nil;
            self.groupedCodeScores[indexPath.section][indexPath.row] = @1;
        }
    }
    else if ([codeScore isEqual:@1]) {
        codeScore = nil;
    }
    
    return codeScore;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self codeForIndexPath:indexPath];
}

- (NSArray *)groupedCodeScores
{
    if (_groupedCodeScores == nil) {
        NSMutableArray *groupedCodeScores = [NSMutableArray arrayWithCapacity:self.subjects.count];
        UBSubject *subject = nil;
        
        for (NSInteger i = 0; i < self.subjects.count; i++) {
            subject = [self subjectForSection:i];
            [groupedCodeScores addObject:[NSMutableArray arrayWithCapacity:subject.codes.count]];
            
            for (NSInteger j = 0; j < subject.codes.count; j++) {
                [groupedCodeScores[i] addObject:[NSNull null]];
            }
        }
        
        _groupedCodeScores = groupedCodeScores;
    }
    
    return _groupedCodeScores;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    
    UITableView *tableView = self.tableView;
    [tableView reloadData];
}

#pragma mark - Table view delegate


- (UITableViewCell *)allocCell:(NSString *)identifier
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UBCode *code = [self codeForIndexPath:indexPath];
    
    CGRect rect = cell.frame;
    rect.origin.y += 20.0f;
    
    self.popover = [[UIPopoverController alloc] initWithContentViewController:[[UBCodeViewController alloc] initWithCode:code]];
    self.popover.contentViewController.view.frame = CGRectMake(0, 0, 300.0f, 300.0f);
    self.popover.popoverContentSize = self.popover.contentViewController.view.frame.size;
    [self.popover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}



@end
