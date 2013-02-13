//
//  UBStudentSelectorView.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBStudentSelectorView.h"

#import "UBStudent.h"

@interface UBStudentSelectorView ()

@property (nonatomic) NSArray *buttons;
@property (nonatomic) NSArray *targets;

@end

@implementation UBStudentSelectorView

@synthesize students = _students;
@synthesize selectedStudents = _selectedStudents;

- (id)initWithStudents:(NSArray *)students
{
    self = [super init];
    if (self) {
        _buttons = @[];
        _targets = @[];
        
        self.allowsMultiple = NO;
        
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
    
    [self clearSubviews];
    
    CGFloat viewPosition = 0;
    UIButton *studentView = nil;
    NSInteger i = 0;
    NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:students.count];
    
    for (UBStudent *student in students) {
        studentView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        studentView.tag = i;
        [studentView setTitle:student.fname forState:UIControlStateNormal];
        [studentView sizeToFit];
        studentView.frame = CGRectMake(viewPosition, 0, studentView.frame.size.width, studentView.frame.size.height);
        viewPosition += studentView.frame.size.width + 2.0f;
        [self addSubview:studentView];
        [studentView addTarget:self action:@selector(selectStudent:) forControlEvents:UIControlEventTouchDown];
        i++;
        [buttons addObject:studentView];
    }
    
    _buttons = buttons;
}

- (void)clearSubviews
{
    for (UIView *view in _buttons) {
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
        sender.backgroundColor = [UIColor whiteColor];
    }
    else {
        if (self.allowsMultiple) {
            _selectedStudents = [_selectedStudents setByAddingObject:student];
            sender.selected = YES;
            sender.backgroundColor = [UIColor blueColor];
        }
        else {
            _selectedStudents = [NSSet setWithObject:student];
        }
    }
    
    for (NSInvocation *invocation in _targets) {
        //[invocation setArgument:(__bridge void *)(student) atIndex:0];
        [invocation invoke];
    }
}

- (void)addTarget:(id)target action:(SEL)action
{
    NSMethodSignature *methodSig = [[target class] instanceMethodSignatureForSelector:action];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
    invocation.target = target;
    invocation.selector = action;
    
    _targets = [_targets arrayByAddingObject:invocation];
}

@end
