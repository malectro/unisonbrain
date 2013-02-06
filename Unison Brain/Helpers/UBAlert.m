//
//  UBAlert.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/6/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBAlert.h"

@implementation UBAlert

+ (void)alert:(NSString *)message
{
    static UIAlertView *alertView = nil;
    
    if (alertView == nil) {
        alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    }
    
    alertView.message = message;
    [alertView show];
}

@end
