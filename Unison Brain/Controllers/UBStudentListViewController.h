//
//  UBStudentListViewController.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/4/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UBListViewDelegate <NSObject>

- (void)didSelectItem:(id)item;

@end

@interface UBStudentListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate>

@property (nonatomic) id<UBListViewDelegate> delegate;
@property (nonatomic) NSArray *students;
@property (nonatomic) NSMutableArray *filteredPeople;

- (id)initWithStudents:(NSArray *)students;

@end
