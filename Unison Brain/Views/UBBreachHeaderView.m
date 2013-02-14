//
//  UBBreachHeaderView.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/8/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBBreachHeaderView.h"

#import <QuartzCore/QuartzCore.h>

#import "UBDate.h"
#import "UBCodeType.h"
#import "UBBreach.h"

@implementation UBBreachHeaderView

@synthesize selected;

- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor whiteColor];
        _backgroundView.opaque = YES;
        //[self addSubview:_backgroundView];
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        _tagList = [[DWTagList alloc]init];
        _tagList.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        
        _deleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //_deleteButton.tintColor = [UIColor redColor];
        [_deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor colorWithRed:0.30f green:0.10f blue:0.10f alpha:1.0f] forState:UIControlStateNormal];
        
    
        [_deleteButton sizeToFit];
        [_deleteButton setHidden:YES];
        
        [self addSubview:_textLabel];
        [self addSubview:_tagList];
        [self addSubview:_deleteButton];
        
        self.selected = NO;
        
        [self addTarget:self action:@selector(showDeleteButton) forControlEvents:UIControlEventTouchDragInside];
        
    }
    return self;
}

- (void)layoutSubviews
{
    _backgroundView.frame = CGRectMake(10.0f, 20.0f, self.frame.size.width - 20.0f, self.frame.size.height - 20.0f);
    
    //old:     _textLabel.frame = CGRectMake(50.0f, 0.0f, self.frame.size.width - 100.0f, self.frame.size.height - 0.0f);
    
    _deleteButton.frame = CGRectMake(640.0f, 10.0f, _deleteButton.frame.size.width, 30.0f);

    
    _textLabel.frame = CGRectMake(50.0f, 0.0f, 200.0f, self.frame.size.height - 0.0f);
    //_tagList.frame = CGRectMake(50.0f, 0.0f, 210.0f, self.frame.size.height);
    _tagList.frame = CGRectMake(260.0f, 10.0f, self.frame.size.width - 270.0f, 20.0f);
    [self reloadHeader];

}

- (void)showDeleteButton
{
    [_deleteButton setHidden:NO];
    [_deleteButton setEnabled:YES];
    [self addTarget:self action:@selector(hideDeleteButton) forControlEvents:UIControlEventTouchDown];
    [_deleteButton addTarget:self action:@selector(deleteBreach) forControlEvents:UIControlEventTouchUpInside];


}

- (void)hideDeleteButton
{
    [_deleteButton setHidden:YES];
    [_deleteButton setEnabled:NO];
    [self removeTarget:self action:@selector(hideDeleteButton) forControlEvents:UIControlEventTouchDown];
}

- (void)deleteBreach
{
    [_delegate deleteBreach:self.breach];
}

- (void)setBreach:(UBBreach *)breach
{
    _breach = breach;
    [self reloadHeader];
}

- (void)reloadHeader
{
    NSString *codes = @"";
    //if (_breach.codeList.length > 2) {
    //    codes = [NSString stringWithFormat:@" | Codes: %@", _breach.codeList];
    //}
    
    self.textLabel.text = [NSString stringWithFormat:@"Type: %@%@", _breach.codeType.name, codes];

    [self.tagList setTags:[[_breach.codes allObjects] valueForKey:@"name"]];
}

- (void)setSelfSelected
{
    [_delegate setSelectedBreach:self.breach];
}

- (void)setSelected:(BOOL)shouldSelect
{
    selected = shouldSelect;
    
    if (selected) {
        _textLabel.textColor = [UIColor darkTextColor];
        [_tagList setLabelBackgroundColor:[UIColor colorWithRed:0.80 green:0.84 blue:0.93 alpha:1.00]];
        //[_tagList setTextColor:[UIColor whiteColor]];
        
    }
    else {
        _textLabel.textColor = [UIColor grayColor];
        [_tagList setLabelBackgroundColor:[UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00]];
        //[_tagList setTextColor:[UIColor blackColor]];

        
    }
}

@end
