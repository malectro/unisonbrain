//
//  UBConferenceCommentViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/25/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBConferenceCommentViewController.h"

@interface UBConferenceCommentViewController ()

@end

@implementation UBConferenceCommentViewController

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
    return @[sortDescriptor, sortDescriptor2];
}

- (NSPredicate *)predicate
{
    return [NSPredicate predicateWithFormat:@"conference.student = %@", self.student];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = @"hi";
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
}

@end
