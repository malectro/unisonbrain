//
//  UBStudentListViewController.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/4/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UBStudentListViewController : UITableViewController<UISearchBarDelegate,UISearchDisplayDelegate>

@property (nonatomic) NSArray *students;
@property (nonatomic) NSMutableArray *filteredPeople;

- (id)initWithStudents:(NSArray *)students;

@end
