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
#import "UBSession.h"
#import "UBConference.h"
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
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ IN people", self.teacher];
    
    NSPredicate *confPredicate = [NSPredicate predicateWithFormat:@"%@ == teacher", self.teacher];
    
    NSSet *thisTeacherSessions = [[NSSet alloc]init];
    NSSet *thisTeacherConferences = [[NSSet alloc]init];

    /// SORTED SESSIONS
    
    if (student.sessions) {
        thisTeacherSessions = [student.sessions filteredSetUsingPredicate:predicate];
    }
    
    NSSortDescriptor *descriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES];
    NSArray *sortedSessions = [thisTeacherSessions sortedArrayUsingDescriptors:@[descriptor1]];

    
    /// SORTED CONFERENCES
    
    if (student.conferences) {
        thisTeacherConferences = [student.conferences filteredSetUsingPredicate:confPredicate];
    }
    
    NSSortDescriptor *descriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES];
    NSArray *sortedConferences = [thisTeacherConferences sortedArrayUsingDescriptors:@[descriptor2]];

    

    NSString *sesh1d = @"No Session";
    NSString *sesh2d = @"No Session";
    NSString *conf3d = @"No Conferences";
    
    int recentSessionCount = 0;
    
    if (sortedSessions.count>0) {
        UBSession *sesh1 = sortedSessions[0];
        sesh1d = [UBDate stringFromDateShort:sesh1.time];
        if ([UBDate wasThisWeek:sesh1.time]) recentSessionCount++;
    }
    
    if (sortedSessions.count>1) {
        UBSession *sesh2 = sortedSessions[1];
        sesh2d = [UBDate stringFromDateShort:sesh2.time];
        if ([UBDate wasThisWeek:sesh2.time]) recentSessionCount++;
    }
    
    if (sortedConferences.count>0) {
        UBConference *conf = sortedConferences[0];
        conf3d = [UBDate stringFromDateShort:conf.time];
    }

    
    [cell.tagList setTags:@[sesh1d, sesh2d]];
    if (recentSessionCount == 2) [cell.tagList setLabelBackgroundColor:[UIColor colorWithHue:0.5f saturation:0.2f brightness:0.9f alpha:1.0f]];
    else if (recentSessionCount == 1) [cell.tagList setLabelBackgroundColor:[UIColor colorWithHue:0.13f saturation:0.2f brightness:0.9f alpha:1.0f]];
    else [cell.tagList setLabelBackgroundColor:[UIColor colorWithHue:0.95f saturation:0.2f brightness:0.9f alpha:1.0f]];
    
    [cell.tagSession setTags: @[conf3d]];
    [cell.tagSession setLabelBackgroundColor:[UIColor colorWithHue:0.5f saturation:0.0f brightness:0.9f alpha:1.0f]];
    
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
