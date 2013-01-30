//
//  UBContribution.h
//  Unison Brain
//
//  Created by Kyle Warren on 1/30/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UBBreach, UBPerson;

@interface UBContribution : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) UBBreach *breach;
@property (nonatomic, retain) UBPerson *person;

@end
