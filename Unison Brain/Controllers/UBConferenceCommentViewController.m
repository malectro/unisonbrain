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

- (id)initWithConference:(UBConference *)conference
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        if (conference != nil) {
            _conference = conference;
        }
        
        self.modelName = @"UBCodeScore";
    }
    return self;
}

- (NSArray *)sortDescriptors
{
    NSSortDescriptor *sortDescriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"code.name" ascending:NO];
    return @[sortDescriptor2];
}

- (NSPredicate *)predicate
{
    return [NSPredicate predicateWithFormat:@"conference = %@", self.conference];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = @"hi";
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
}

@end
