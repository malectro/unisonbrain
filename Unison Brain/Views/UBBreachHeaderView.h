//
//  UBBreachHeaderView.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/8/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UBBreach;

@interface UBBreachHeaderView : UIView

@property (nonatomic) UBBreach *breach;
@property (nonatomic) BOOL selected;

@property (nonatomic, readonly) UILabel *textLabel;
@property (nonatomic, readonly) UIView *backgroundView;

- (void)reloadHeader;


@end
