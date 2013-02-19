//
//  UBStudentViewController.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/19/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UBStudent, UBStudentView;

@interface UBStudentViewController : UIViewController

@property (nonatomic) UBStudent *student;
@property (nonatomic) UBStudentView *studentView;

- (id)initWithStudent:(UBStudent *)student;

@end
