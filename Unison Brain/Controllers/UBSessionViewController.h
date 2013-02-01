//
//  UBSessionViewController.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UBSession;

@interface UBSessionViewController : UIViewController

@property (nonatomic, retain) UBSession *session;

- (id)initWithSession:(UBSession *)session;

@end
