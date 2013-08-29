//
//  UBStudentView.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/19/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UBStudentView : UIView

@property (nonatomic) UIView *contributionsView;
@property (nonatomic) UIView *codesView;
@property (nonatomic) UIView *conferencesView;
@property (nonatomic) UIView *conferenceView;
@property (nonatomic) UIButton *createConference, *editConference;
@property (nonatomic, readonly) UIScrollView *conferenceMetaView;

- (void)showConferencesView;
- (void)showConferenceView;

@end
