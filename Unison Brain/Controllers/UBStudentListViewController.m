//
//  UBStudentListViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/4/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBStudentListViewController.h"

#import "UBPerson.h"

@interface UBStudentListViewController ()

@property (nonatomic) UISearchBar *searchBar;

@end

@implementation UBStudentListViewController

@synthesize students = _students;
@synthesize filteredPeople = _filteredPeople;
@synthesize searchBar = _searchBar;

- (id)initWithStudents:(NSArray *)students
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.students = students;
        
        _searchBar = [[UISearchBar alloc] init];
        _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
        _searchDisplayController.delegate = self;
        _searchDisplayController.searchResultsDataSource = self;
        _searchDisplayController.searchResultsDelegate = self;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    _filteredPeople = [NSMutableArray arrayWithCapacity:_students.count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Mutators

- (void)setStudents:(NSArray *)students
{
    _students = students;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return _students.count;
    }
    else {
        return _filteredPeople.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    UBPerson *person = nil;
    if (tableView == self.tableView) {
        person = [self personForIndexPath:indexPath];
    }
    else {
        person = [self filteredPersonForIndexPath:indexPath];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", person.fname, person.lname];
    
    return cell;
}

- (UBPerson *)personForIndexPath:(NSIndexPath *)indexPath
{
    return _students[indexPath.row];
}

- (UBPerson *)filteredPersonForIndexPath:(NSIndexPath *)indexPath
{
    return _filteredPeople[indexPath.row];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - SearchDisplayController Delegate Data Source Stuff

- (void)filterContentForSearchText:(NSString *)searchText
{	
	[_filteredPeople removeAllObjects];
	
	for (UBPerson *person in _students) {
        NSComparisonResult result = [person.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if (result == NSOrderedSame) {
            [_filteredPeople addObject:person];
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
