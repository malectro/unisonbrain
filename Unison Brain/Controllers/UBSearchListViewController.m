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
        _searchController.searchResultsTableView.allowsMultipleSelection = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:_searchBar];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.allowsMultipleSelection = YES;
    
    [self.view addSubview:self.tableView];
    
    [_searchBar becomeFirstResponder];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    _searchBar.frame = CGRectMake(0, 0.0f, self.view.frame.size.width, 44.0f);
    self.tableView.frame = CGRectMake(0, _searchBar.frame.size.height + _searchBar.frame.origin.y + 0.0f, self.view.frame.size.width, self.view.frame.size.height - _searchBar.frame.size.height - _searchBar.frame.origin.y);
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
    _selectedItems = [NSMutableArray arrayWithCapacity:_items.count];
    _deselectedItems = [NSMutableArray arrayWithArray:_items];
    
    [self.tableView reloadData];
}

- (void)setSelection:(NSArray *)selectedItems
{
    _selectedItems = [NSMutableArray arrayWithArray:selectedItems];
    _deselectedItems = [NSMutableArray arrayWithArray:_items];
    [_deselectedItems removeObjectsInArray:_selectedItems];
    [self.tableView reloadData];
    
    // i can't BELIEVE i have to do this
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    for (NSInteger i = 0; i < _selectedItems.count; i++) {
        indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

- (void)selectItems:(NSArray *)items
{
    [_selectedItems addObjectsFromArray:items];
    [_deselectedItems removeObjectsInArray:_selectedItems];
}

- (void)deselectItems:(NSArray *)items
{
    [_selectedItems removeObjectsInArray:items];
    _deselectedItems = [NSMutableArray arrayWithArray:_items];
    [_deselectedItems removeObjectsInArray:_selectedItems];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return _items.count;
    }
    else {
        //hack
        tableView.allowsMultipleSelection = YES;
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
    
    id item = [self tableView:tableView itemForIndexPath:indexPath];
    
    [self configureCell:cell withItem:item];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell withItem:(id)item
{
    cell.textLabel.text = @"Cell";
}

- (id)tableView:(UITableView *)tableView itemForIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        if (indexPath.row < _selectedItems.count) {
            return _selectedItems[indexPath.row];
        }
        else {
            return _deselectedItems[indexPath.row - _selectedItems.count];
        }
    }
    else {
        return _filteredItems[indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self tableView:tableView itemForIndexPath:indexPath];
    NSInteger oldRow = _selectedItems.count + [_deselectedItems indexOfObject:item];
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:oldRow inSection:0];
    
    // performance issue?
    [self selectItems:@[item]];
    
    [self.tableView selectRowAtIndexPath:oldIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self.tableView moveRowAtIndexPath:[NSIndexPath indexPathForRow:oldRow inSection:0] toIndexPath:[NSIndexPath indexPathForRow:(_selectedItems.count - 1) inSection:0]];
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(searchList:didSelectItem:)]) {
        [self.delegate searchList:self didSelectItem:item];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self tableView:tableView itemForIndexPath:indexPath];
    NSInteger oldRow = [_selectedItems indexOfObject:item];
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:oldRow inSection:0];
    
    // performance issue?
    [self deselectItems:@[item]];
    
    NSInteger row = [_deselectedItems indexOfObject:item] + _selectedItems.count;
    
    [self.tableView deselectRowAtIndexPath:oldIndexPath animated:YES];
    [self.tableView moveRowAtIndexPath:oldIndexPath toIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(searchList:didDeselectItem:)]) {
        [self.delegate searchList:self didDeselectItem:item];
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
