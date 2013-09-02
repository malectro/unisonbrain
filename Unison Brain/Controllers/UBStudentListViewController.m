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
#import "UBDate.h"  
#import "UBStudentCell.h"

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

- (UITableViewCell *)allocCell:(NSString *)identifier
{
    UITableViewCell *cell = [[UBStudentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.textLabel.font = [UIFont systemFontOfSize:18.0f];
    return cell;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)configureCell:(UBStudentCell *)cell withItem:(UBStudent *)student
{
    cell.name.text = student.name;
    cell.section.text = student.section;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"teacher = %@", self.teacher];
    
    NSSet *thisTeacherSessions = [[NSSet alloc]init];
    
    if (student.sessions) {
        thisTeacherSessions = [student.sessions filteredSetUsingPredicate:predicate];
    }
    
    NSSortDescriptor *descriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES];
    NSArray *sortedSessions = [thisTeacherSessions sortedArrayUsingDescriptors:@[descriptor1]];

    // UBSession *sesh1 = sortedSessions[0];
    // UBSession *sesh2 = sortedSessions[1];

    NSString *sesh1d = @"No Session";
    NSString *sesh2d = @"No Session";
    
    if (sortedSessions.count>0) {sesh1d = [UBDate stringFromDateMedium:[sortedSessions[0] objectForKey:@"time"]];}
    if (sortedSessions.count>1) {sesh2d = [UBDate stringFromDateMedium:[sortedSessions[1] objectForKey:@"time"]];}
    
    [cell.tagList setTags:@[sesh1d, sesh2d]];
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
