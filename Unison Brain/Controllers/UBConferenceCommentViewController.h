//
//  UBConferenceCommentViewController.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/25/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBModelTableViewController.h"

@class UBConference;

@interface UBConferenceCommentViewController : UBModelTableViewController

@property (nonatomic) UBConference *conference;

- (id)initWithConference:(UBConference *)conference;

@end
