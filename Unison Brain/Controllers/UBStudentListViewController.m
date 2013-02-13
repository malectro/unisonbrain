//
//  UBStudentListViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/4/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBStudentListViewController.h"

#import "UBPerson.h"
#import "UBStudent.h"

@interface UBStudentListViewController ()

@end

@implementation UBStudentListViewController

- (id)init
{
    self = [super initWithItems:[UBStudent all]];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadStudents) name:@"UBStudent:fetchAll" object:nil];
    }
    return self;
}

- (id)initWithItems:(NSArray *)items
{
    return [super initWithItems:[UBStudent all]];
}

- (void)configureCell:(UITableViewCell *)cell withItem:(UBStudent *)student
{
    cell.textLabel.text = student.name;
}

- (BOOL)filterItem:(UBStudent *)student bySearch:(NSString *)searchText
{
    NSComparisonResult result = [student.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
    return result == NSOrderedSame;
}

- (void)reloadStudents
{
    self.items = [UBStudent all];
}

@end
