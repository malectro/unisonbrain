//
//  UBCodesViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/7/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBCodesViewController.h"

#import "UBCode.h"

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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    self.items = [UBCode all];
}


@end
