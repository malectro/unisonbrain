//
//  UBModel.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/1/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface UBModel : NSManagedObject

+ (id)create;

+ (NSString *)name;
+ (NSString *)url;

@end
