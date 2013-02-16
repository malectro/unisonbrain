//
//  UBLoginView.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/16/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBLoginView.h"

#import "UBFunctions.h"

#define kStatusBarHeight 20.0f
#define kTextFieldWidth 300.0f
#define kTextFieldHeight 40.0f

@implementation UBLoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default-Landscape"]];
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:_background];
        
        _usernameField = [[UITextField alloc] init];
        _usernameField.placeholder = @"Username...";
        _usernameField.backgroundColor = [UIColor whiteColor];
        _usernameField.borderStyle = UITextBorderStyleRoundedRect;
        _usernameField.font = [UIFont systemFontOfSize:24.0f];
        _usernameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self addSubview:_usernameField];
        
        _passwordField = [[UITextField alloc] init];
        _passwordField.secureTextEntry = YES;
        _passwordField.placeholder = @"Password...";
        _passwordField.backgroundColor = [UIColor whiteColor];
        _passwordField.borderStyle = UITextBorderStyleRoundedRect;
        _passwordField.font = [UIFont systemFontOfSize:24.0f];
        _passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self addSubview:_passwordField];
    }
    return self;
}

- (void)layoutSubviews
{
    _background.frame = CGRectMake(0, -kStatusBarHeight, _background.image.size.width, _background.image.size.height);
    _usernameField.frame = CGRectMake((self.frame.size.width - kTextFieldWidth) / 2.0f, 100.0f - kStatusBarHeight, kTextFieldWidth, kTextFieldHeight);
    _passwordField.frame = CGRectPosition(_usernameField.frame, _usernameField.frame.origin.x, _usernameField.frame.origin.y + kTextFieldHeight + 20.0f);
}

@end
