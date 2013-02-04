//
//  UBPerson.m
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBPerson.h"
#import "UBBreach.h"
#import "UBContribution.h"
#import "UBSession.h"


@implementation UBPerson

@synthesize name = _name;

@dynamic fname;
@dynamic lname;
@dynamic school;
@dynamic breaches;
@dynamic contributions;
@dynamic sessions;

- (NSString *)name
{
    if (_name == nil) {
        _name = [NSString stringWithFormat:@"%@ %@", self.fname, self.lname];
    }
    return _name;
}

@end
