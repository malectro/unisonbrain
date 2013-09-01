//
//  UBCodeViewController.h
//  Unison Brain
//
//  Created by Kyle Warren on 5/23/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UBCode;

@interface UBCodeViewController : UIViewController

@property (nonatomic) UBCode *code;
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UILabel *descriptionLabel;
@property (nonatomic) CGSize contentSize;


- (id)initWithCode:(UBCode *)code;

@end
