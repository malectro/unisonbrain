//
//  UBSearchListViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/7/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBSearchListViewController.h"

@interface UBSearchListViewController ()

@end

@implementation UBSearchListViewController

- (id)initWithItems:(NSArray *)items
{
    self = [super init];
    if (self) {
        if (items != nil) {
            self.items = items;
        }
        
        _searchBar = [[UISearchBar alloc] init];
        _searchController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
        _searchController.delegate = self;
        _searchController.searchResultsDataSource = self;
        _searchController.searchResultsDelegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _searchBar.frame = CGRectMake(0, 0.0f, self.view.frame.size.width, 44.0f);
    [self.view addSubview:_searchBar];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.frame = CGRectMake(0, _searchBar.frame.size.height + _searchBar.frame.origin.y + 0.0f, self.view.frame.size.width, self.view.frame.size.height - _searchBar.frame.size.height - _searchBar.frame.origin.y);
    [self.view addSubview:self.tableView];
    
    [_searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    _filteredItems = [NSMutableArray arrayWithCapacity:_items.count];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return _items.count;
    }
    else {
        return _filteredItems.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [self configureCell:cell withItem:[self tableView:tableView itemForIndexPath:indexPath]];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell withItem:(id)item
{
    cell.textLabel.text = @"Cell";
}

- (id)tableView:(UITableView *)tableView itemForIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        return _items[indexPath.row];
    }
    else {
        return _filteredItems[indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView cellForRowAtIndexPath:indexPath].selected = NO;
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(searchList:didSelectItem:)]) {
        [self.delegate searchList:self didSelectItem:[self tableView:tableView itemForIndexPath:indexPath]];
    }
}

- (BOOL)filterItem:(id)item bySearch:(NSString *)searchText
{
    // override this
    return YES;
}

- (void)filterContentForSearchText:(NSString *)searchText
{
	[_filteredItems removeAllObjects];
	
	for (id item in _items) {
        if ([self filterItem:item bySearch:searchText]) {
            [_filteredItems addObject:item];
        }
	}
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

@end
