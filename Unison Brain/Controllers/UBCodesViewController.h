//
//  UBCodesViewController.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/7/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UBSearchListViewController.h"

@class UBSubject;

@interface UBCodesViewController : UBSearchListViewController

@property (nonatomic) UBSubject *subject;

@property (nonatomic) UIPopoverController *popover;

@end
