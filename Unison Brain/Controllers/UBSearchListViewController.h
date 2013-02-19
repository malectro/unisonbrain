//
//  UBSearchListViewController.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/7/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UBSearchListViewDelegate;

@interface UBSearchListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate>

@property (nonatomic) id<UBSearchListViewDelegate> delegate;
@property (nonatomic) NSArray *items;
@property (nonatomic) NSMutableArray *filteredItems;
@property (nonatomic) NSMutableArray *selectedItems;
@property (nonatomic) NSMutableArray *deselectedItems;
@property (nonatomic) BOOL allowsMultipleSelection;

@property (nonatomic, readonly) UISearchBar *searchBar;
@property (nonatomic, readonly) UISearchDisplayController *searchController;
@property (nonatomic, readonly) UITableView *tableView;

- (id)initWithItems:(NSArray *)items;

- (void)configureCell:(UITableViewCell *)cell withItem:(id)item;
- (BOOL)filterItem:(id)item bySearch:(NSString *)searchText;
- (void)setSelection:(NSArray *)selectedItems;

@end

@protocol UBSearchListViewDelegate <NSObject>

@optional

- (void)searchList:(UBSearchListViewController *)searchList didSelectItem:(id)item;
- (void)searchList:(UBSearchListViewController *)searchList didDeselectItem:(id)item;

@end