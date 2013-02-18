//
//  UBLoginView.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/16/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UBLoginView : UIView

@property (nonatomic, readonly) UIImageView *background;
@property (nonatomic, readonly) UITextField *usernameField;
@property (nonatomic, readonly) UITextField *passwordField;
@property (nonatomic, readonly) UIButton *loginButton;

@end
