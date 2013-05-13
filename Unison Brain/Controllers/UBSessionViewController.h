//
//  UBSessionViewController.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UBStudentListViewController.h"
#import "UBDatePickerViewController.h"
#import "UBBreachHeaderView.h"

@class UBSession;
@class UBContributionCell;

@interface UBSessionViewController : UIViewController<UBSearchListViewDelegate,UITableViewDataSource,UITableViewDelegate, UBDatePickerDelegate, UIPopoverControllerDelegate, UIActionSheetDelegate, UBBreachHeaderDelegate>

@property (nonatomic, retain) UBSession *session;

- (id)initWithSession:(UBSession *)session;

- (void)setSelectedBreach:(UBBreach *)selectedBreach;
- (void)beganEditingContribution:(UBContributionCell *)contributionCell;
- (void)editedContribution:(UBContributionCell *)contributionCell;


@end
