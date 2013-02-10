//
//  UBType.h
//  Unison Brain
//
//  Created by Amy Piller on 2/10/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UBModel.h"


@interface UBType : UBModel

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *codes;


@end
