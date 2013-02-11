//
//  UBRequest.h
//  Unison Brain
//
//  Created by Kyle Warren on 2/10/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UBRequest : NSObject

+ (void)get:(NSString *)path callback:(void (^)(id)) handler NS_AVAILABLE(10_7, 5_0);

@end
