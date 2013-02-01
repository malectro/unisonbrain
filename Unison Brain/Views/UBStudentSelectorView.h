//
//  UBStudentSelectorView.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UBStudentSelectorView : UIView

@property (nonatomic, retain) NSArray *students;
@property (nonatomic, retain, readonly) NSSet *selectedStudents;


- (id)initWithStudents:(NSArray *)students;

@end
