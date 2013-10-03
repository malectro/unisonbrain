//
//  UBHomeViewController.h
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBSearchListViewController.h"

@interface UBHomeViewController : UIViewController<UBSearchListViewDelegate>;

- (void) reloadData;


@end
