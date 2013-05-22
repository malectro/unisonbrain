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
#import "UBTeacher.h"

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

- (id)initWithTeacher:(UBTeacher *)teacher
{
    self = [super initWithItems:teacher.students.allObjects];
    if (self) {
        _teacher = teacher;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadStudents) name:@"UBStudent:fetchAll" object:nil];
    }
    return self;
}

- (id)initWithItems:(NSArray *)items
{
    return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.allowsMultipleSelection = YES;
    self.allowsSelectionGrouping = YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    if (self.teacher) {
        self.items = self.teacher.students.allObjects;
    } else {
        self.items = [UBStudent all];
    }
}

- (void)setTeacher:(UBTeacher *)teacher
{
    _teacher = teacher;
    [self reloadStudents];
}

@end
