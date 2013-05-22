//
//  UBSearchListViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/7/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBSearchListViewController.h"

@interface UBSearchListViewController () {
    NSIndexPath *_deselectedPath;
}

@end

@implementation UBSearchListViewController

- (id)initWithItems:(NSArray *)items
{
    self = [super init];
    if (self) {
        if (items != nil) {
            self.items = items;
        }
        
        _allowsMultipleSelection = NO;
        _allowsSelectionGrouping = NO;
        
        _searchBar = [[UISearchBar alloc] init];
        _searchController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
        _searchController.delegate = self;
        _searchController.searchResultsDataSource = self;
        _searchController.searchResultsDelegate = self;
        _searchController.searchResultsTableView.allowsMultipleSelection = _allowsMultipleSelection;
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
    self.tableView.allowsMultipleSelection = self.allowsMultipleSelection;
    
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

- (void)setAllowsMultipleSelection:(BOOL)allowsMultipleSelection
{
    _allowsMultipleSelection = allowsMultipleSelection;
    _searchController.searchResultsTableView.allowsMultipleSelection = _allowsMultipleSelection;
    self.tableView.allowsMultipleSelection = _allowsMultipleSelection;
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    _filteredItems = [NSMutableArray arrayWithCapacity:_items.count];
    _selectedItems = [NSMutableArray arrayWithCapacity:_items.count];
    _deselectedItems = [NSMutableArray arrayWithArray:_items];
    [self.tableView reloadData];
    //[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)setSelection:(NSArray *)selectedItems
{
    NSMutableOrderedSet *selectedSet = [NSMutableOrderedSet orderedSetWithArray:selectedItems];
    NSOrderedSet *itemsSet = [NSOrderedSet orderedSetWithArray:_items];
    [selectedSet intersectOrderedSet:itemsSet];
    
    _selectedItems = [NSMutableArray arrayWithArray:selectedSet.array];
    
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
        cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
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
    // stupid hack because selected indexPaths do not reflect recent table changes
    if (!self.allowsMultipleSelection && _deselectedPath && _deselectedPath.row >= indexPath.row) {
        indexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
    }
    
    id item = [self tableView:tableView itemForIndexPath:indexPath];
    
    if (self.allowsSelectionGrouping) {
        // this is a total hack, but apparently uitableviews don't allow deselection without multipleselection = YES
        if (!self.allowsMultipleSelection) {
            if ([_selectedItems indexOfObject:item] != NSNotFound) {
                [self tableView:tableView didDeselectRowAtIndexPath:indexPath];
                _deselectedPath = nil;
                return;
            }
        }
        
        NSInteger oldRow = _selectedItems.count + [_deselectedItems indexOfObject:item];
        
        // performance issue?
        [self selectItems:@[item]];
        
        NSIndexPath *someIndexPath = [NSIndexPath indexPathForRow:(_selectedItems.count - 1) inSection:0];
        
        //[self.tableView selectRowAtIndexPath:oldIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        [self.tableView moveRowAtIndexPath:[NSIndexPath indexPathForRow:oldRow inSection:0] toIndexPath:someIndexPath];
        [self.tableView selectRowAtIndexPath:someIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(searchList:didSelectItem:)]) {
        [self.delegate searchList:self didSelectItem:item];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self tableView:tableView itemForIndexPath:indexPath];
    
    if (self.allowsSelectionGrouping) {
        NSInteger oldRow = [_selectedItems indexOfObject:item];
        NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:oldRow inSection:0];
        
        // performance issue?
        [self deselectItems:@[item]];
        
        NSInteger row = [_deselectedItems indexOfObject:item] + _selectedItems.count;
        
        _deselectedPath = [NSIndexPath indexPathForRow:row inSection:0];
        
        [self.tableView beginUpdates];
        [self.tableView deselectRowAtIndexPath:oldIndexPath animated:YES];
        [self.tableView moveRowAtIndexPath:oldIndexPath toIndexPath:_deselectedPath];
        [self.tableView endUpdates];
    }
    
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
