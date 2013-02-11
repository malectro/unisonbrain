//
//  UBBreachHeaderView.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/8/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBBreach.h"

@protocol UBBreachHeaderDelegate

@optional
- (void)setSelectedBreach:(UBBreach *)selectedBreach;
@end


@class UBBreach;

@interface UBBreachHeaderView : UIControl

@property (nonatomic) UBBreach *breach;
@property (nonatomic) BOOL selected;
@property (weak, nonatomic) NSObject<UBBreachHeaderDelegate> *delegate;

@property (nonatomic, readonly) UILabel *textLabel;
@property (nonatomic, readonly) UIView *backgroundView;

- (void)reloadHeader;
- (void)setSelfSelected;


@end
