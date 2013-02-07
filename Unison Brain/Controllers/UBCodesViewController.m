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
    return [super initWithItems:[UBCode all]];
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



@end
