//
//  UBCodeViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 5/23/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBCodeViewController.h"

#import "UBCode.h"

@interface UBCodeViewController ()

@end

@implementation UBCodeViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont systemFontOfSize:30.0f];
        
        self.descriptionLabel = [[UILabel alloc] init];
        self.descriptionLabel.numberOfLines = 0;
        self.descriptionLabel.font = [UIFont systemFontOfSize:16.0f];
    }
    return self;
}

- (id)initWithCode:(UBCode *)code
{
    self = [self init];
    if (self) {
        self.code = code;
    }
    return self;
}

- (void)loadView
{
    self.view = self.scrollView = [[UIScrollView alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    [self.scrollView addSubview:self.nameLabel];
    [self.scrollView addSubview:self.descriptionLabel];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGSize descriptionSize = CGSizeMake(self.scrollView.frame.size.width, 1000000000.0f);
    descriptionSize = [self.descriptionLabel.text sizeWithFont:self.descriptionLabel.font constrainedToSize:descriptionSize lineBreakMode:NSLineBreakByWordWrapping];
    
    self.nameLabel.frame = CGRectMake(5.0f, 0, self.scrollView.frame.size.width, 40.0f);
    self.descriptionLabel.frame = CGRectMake(5.0f, self.nameLabel.frame.size.height, descriptionSize.width, descriptionSize.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setCode:(UBCode *)code
{
    _code = code;
    self.title = code.name;
    self.nameLabel.text = code.name;
    self.descriptionLabel.text = code.text;
}

@end
