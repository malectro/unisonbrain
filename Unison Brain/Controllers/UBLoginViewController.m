//
//  UBLoginViewController.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/16/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBLoginViewController.h"

#import "UBLoginView.h"
#import "UBUser.h"
#import "UBAlert.h"
#import "MBProgressHUD.h"

@interface UBLoginViewController ()

@end

@implementation UBLoginViewController

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadView
{
    self.view = self.loginView = [[UBLoginView alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.loginView.loginButton addTarget:self action:@selector(logIn) forControlEvents:UIControlEventTouchDown];
    self.loginView.usernameField.delegate = self;
    self.loginView.passwordField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logIn
{
    if (self.loginView.usernameField.text && self.loginView.passwordField.text) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"Authenticating...";
        
        [[UBUser currentUser] logIn:self.loginView.usernameField.text password:self.loginView.passwordField.text success:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        } failure:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [UBAlert alert:@"We failed to identify you. Please try again."];
            });
        }];
    }
    else {
        [UBAlert alert:@"Please enter your email address and password."];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (textField == self.loginView.usernameField) {
        [self.loginView.passwordField becomeFirstResponder];
    }
    else if (textField == self.loginView.passwordField) {
        [self logIn];
    }
}

@end
