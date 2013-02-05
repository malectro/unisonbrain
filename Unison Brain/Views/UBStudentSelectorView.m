//
//  UBStudentSelectorView.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBStudentSelectorView.h"

#import "UBStudent.h"

@implementation UBStudentSelectorView

@synthesize students = _students;
@synthesize selectedStudents = _selectedStudents;

- (id)initWithStudents:(NSArray *)students
{
    self = [super init];
    if (self) {
        if (students != nil) {
            self.students = students;
        }
    }
    return self;
}

- (void)setStudents:(NSArray *)students
{
    _students = students;
    _selectedStudents = [[NSSet alloc] init];
    
    NSLog(@"students %@", _students);
    
    [self clearSubviews];
    
    CGFloat viewPosition = 0;
    UIButton *studentView = nil;
    NSInteger i = 0;
    
    for (UBStudent *student in students) {
        studentView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        studentView.tag = i;
        [studentView setTitle:student.fname forState:UIControlStateNormal];
        [studentView sizeToFit];
        studentView.frame = CGRectMake(viewPosition, 0, studentView.frame.size.width, studentView.frame.size.height);
        viewPosition += studentView.frame.size.width + 2.0f;
        [self addSubview:studentView];
        [studentView addTarget:self action:@selector(selectStudent:) forControlEvents:UIControlEventTouchDown];
    }
}

- (void)clearSubviews
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

- (void)selectStudent:(UIButton *)sender
{
    UBStudent *student = _students[sender.tag];
    
    if ([_selectedStudents containsObject:student]) {
        NSMutableSet *tempSet = [NSMutableSet setWithSet:_selectedStudents];
        [tempSet removeObject:student];
        _selectedStudents = [NSSet setWithSet:tempSet];
        sender.selected = NO;
    }
    else {
        _selectedStudents = [_selectedStudents setByAddingObject:student];
        sender.selected = YES;
    }
}

@end
