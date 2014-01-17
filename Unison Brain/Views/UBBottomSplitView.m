//
//  UBBottomSplitView.m
//  unison
//
//  Created by Amy Piller on 1/16/14.
//  Copyright (c) 2014 Kyle Warren. All rights reserved.
//

#import "UBBottomSplitView.h"

@implementation UBBottomSplitView

@synthesize studentView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)keyboardWillShow:(NSNotification*)notification {

    [studentView bottomSplitShouldAvoidKeyboard];

}


- (void)keyboardWillHide:(NSNotification*)notification {
    
    [studentView autoscrollComments];
    
}

@end
