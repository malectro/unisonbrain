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

@synthesize contentSize;


- (id)init
{
    self = [super init];
    if (self) {
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont systemFontOfSize:20.0f];
        
        self.descriptionLabel = [[UILabel alloc] init];
        self.descriptionLabel.numberOfLines = 0;
        self.descriptionLabel.font = [UIFont systemFontOfSize:16.0f];
        
        [self configureView];

    
    }
    return self;
}

- (id)initWithCode:(UBCode *)code
{
    self = [self init];
    if (self) {
        self.code = code;
        [self configureView];
        
    }
    return self;
}

- (void) configureView {
    self.view = self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.contentInset = UIEdgeInsetsMake(2.0f, 2.0f, 2.0f, 9.0f);
    
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.nameLabel];
    [self.scrollView addSubview:self.descriptionLabel];
    
    CGSize descriptionSize = CGSizeMake(250.0f, 1000000.0f);
    contentSize = [self.descriptionLabel.text sizeWithFont:self.descriptionLabel.font constrainedToSize:descriptionSize lineBreakMode:NSLineBreakByWordWrapping];
    
    if (contentSize.height<400.0f) {
        self.scrollView.frame = CGRectMake(0.0f, 0.0f, self.scrollView.frame.size.width, contentSize.height);
    }
    
    else{
        self.scrollView.frame = CGRectMake(0.0f, 0.0f, self.scrollView.frame.size.width, 400.0f);
    }

    
}

- (void)loadView
{
    

    [super loadView];

}

- (void)viewDidLoad
{
    [super viewDidLoad];

}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    
    
    self.nameLabel.frame = CGRectMake(5.0f, 5.0f, self.scrollView.frame.size.width, 33.0f);
    self.descriptionLabel.frame = CGRectMake(5.0f, self.nameLabel.frame.size.height, contentSize.width, contentSize.height);
    
    

    
    
    
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
