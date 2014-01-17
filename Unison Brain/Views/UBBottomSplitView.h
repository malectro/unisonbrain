//
//  UBBottomSplitView.h
//  unison
//
//  Created by Amy Piller on 1/16/14.
//  Copyright (c) 2014 Kyle Warren. All rights reserved.
//

#import "TPKeyboardAvoidingScrollView.h"
#import "UBStudentView.h"

@interface UBBottomSplitView : TPKeyboardAvoidingScrollView

@property (nonatomic) UBStudentView *studentView;
@end
