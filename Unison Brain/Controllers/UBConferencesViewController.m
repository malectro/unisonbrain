//
//  UBConferencesViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/25/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBConferencesViewController.h"

#import "UBDate.h"
#import "UBPerson.h"
#import "UBTeacher.h"
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    
    NSString *teacerhName  = [conf.teacher name];
    
    if (conf.teacher == [UBUser currentTeacher]) {
        teacerhName = @"You";
    }
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ with %@", [UBDate stringFromDateMedium:conf.time], teacerhName, conf.notes];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    
    if (conf.complete) {
        cell.textLabel.text = @"Complete";
    } else {
        cell.textLabel.text = @"Incomplete";
    }
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    
    if (conf.teacher != [UBUser currentUser].teacher) {
        cell.backgroundColor = [UIColor colorWithHue:1.0f saturation:0.0f brightness:0.95f alpha:1.0f];
    }
}

- (UITableViewCell *)allocCell:(NSString *)identifier
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier];
    [cell setIndentationWidth:130.0f];
    
    return cell;
}


- (UBConference *)conferenceAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}



@end
