//
//  UBArrayTableViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 5/13/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBArrayTableViewController.h"

@interface UBArrayTableViewController ()

@property (nonatomic) NSArray *targets;

@end

@implementation UBArrayTableViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _items = @[];
        _targets = @[];
    }
    return self;
}

- (id)initWithItems:(NSArray *)items
{
    self = [super init];
    if (self) {
        self.items = items;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.items[indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.lastSelectedIndex = indexPath.row;
    
    for (NSInvocation *invocation in _targets) {
        //[invocation setArgument:self.lastSelectedIndex atIndex:0];
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

- (CGSize)contentSizeForViewInPopover
{
    return CGSizeMake(200.0f, 300.0f);
}

@end
