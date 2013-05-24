//
//  UBCodesViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/7/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBCodesViewController.h"

#import "UBCode.h"
#import "UBCodeViewController.h"

@interface UBCodesViewController ()

@end

@implementation UBCodesViewController

- (id)initWithItems:(NSArray *)items
{
    self = [super initWithItems:[UBCode all]];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadCodes) name:@"UBCode:fetchAll" object:nil];
    }
    return self;
}

- (id)init
{
    return [self initWithItems:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.allowsMultipleSelection = YES;
    self.allowsSelectionGrouping = YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UITableViewCell *)allocCell:(NSString *)identifier
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell withItem:(UBCode *)code
{
    cell.textLabel.text = code.name;
}

- (BOOL)filterItem:(UBCode *)code bySearch:(NSString *)searchText
{
    NSComparisonResult result = [code.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
    return result == NSOrderedSame;
}

- (void)reloadCodes
{
    if (self.subject == nil) {
        self.items = [UBCode all];
    } else {
        self.items = self.subject.codes.allObjects;
    }
}

- (void)setSubject:(UBSubject *)subject
{
    _subject = subject;
    [self reloadCodes];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UBCode *code = [self tableView:tableView itemForIndexPath:indexPath];
    
    CGRect rect = cell.frame;
    rect.origin.y += 20.0f;
    
    self.popover = [[UIPopoverController alloc] initWithContentViewController:[[UBCodeViewController alloc] initWithCode:code]];
    self.popover.contentViewController.view.frame = CGRectMake(0, 0, 300.0f, 300.0f);
    self.popover.popoverContentSize = self.popover.contentViewController.view.frame.size;
    [self.popover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


@end
