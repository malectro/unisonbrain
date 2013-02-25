//
//  UBConferenceCommentViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/25/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBConferenceCommentViewController.h"

#import "UBFunctions.h"

#import "UBCodeScore.h"

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

- (void)viewDidLoad
{
    UIView *headerView = [[UIView alloc] init];
    UILabel *headerLabel = [[UILabel alloc] init];
    
    headerLabel.text = @"New Comment";
    [headerLabel sizeToFit];
    headerLabel.frame = CGRectPosition(headerLabel.frame, 10.0f, 0);
    
    [headerView addSubview:headerLabel];
    
    UIButton *headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIColor *color = [UIColor blueColor];
    CGRect rect = CGRectMake(0, 0, 1.0f, 1.0f);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [headerButton setTitle:@"New Comment" forState:UIControlStateNormal];
    headerButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    headerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    headerButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10.0f, 0, 0);
    [headerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [headerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [headerButton setBackgroundImage:image forState:UIControlStateHighlighted];
    [headerButton sizeToFit];
    headerButton.frame = CGRectMake(0, 0, 0, 44.0f);
    
    [headerButton addTarget:self action:@selector(createCodeScore) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableHeaderView = headerButton;
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
    UBCodeScore *codeScore = [self codeScoreForIndexPath:indexPath];
    cell.textLabel.text = codeScore.comment;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
}

- (UBCodeScore *)codeScoreForIndexPath:(NSIndexPath *)indexPath
{
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

- (void)createCodeScore
{
    UBCodeScore *codeScore = [UBCodeScore create];
    codeScore.conference = self.conference;
}

@end
