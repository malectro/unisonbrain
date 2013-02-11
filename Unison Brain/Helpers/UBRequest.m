//
//  UBRequest.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/10/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBRequest.h"

@implementation UBRequest

+ (void)get:(NSString *)path callback:(void (^)(id))handler
{
    static NSURL *baseUrl = nil;
    static NSOperationQueue *queue = nil;
    
    path = [path stringByAppendingString:@".json"];
    
    if (baseUrl == nil) {
        baseUrl = [NSURL URLWithString:@"http://localhost:3000"];
        queue = [[NSOperationQueue alloc] init];
    }
    
    NSURL *url = [baseUrl URLByAppendingPathComponent:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSArray *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        handler(dict);
    }];
}

@end
