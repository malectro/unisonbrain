//
//  UBRequest.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/10/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBRequest.h"

#import "Reachability.h"

#define kHostName @"http://localhost:3000"

@interface UBRequest ()

@property (nonatomic) Reachability *reachable;
@property (nonatomic) NSOperationQueue *operationQueue;
@property (nonatomic) NSURL *baseUrl;

@end

@implementation UBRequest

+ (UBRequest *)ubr
{
    static UBRequest *requester = nil;
    
    if (requester == nil) {
        requester = [[UBRequest alloc] init];
    }
    
    return requester;
}

+ (void)get:(NSString *)path callback:(void (^)(id))handler
{
    [[self ubr] get:path callback:handler];
}

- (id)init
{
    self = [super init];
    if (self) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 1;
        
        _baseUrl = [NSURL URLWithString:kHostName];
        
        _reachable = [Reachability reachabilityWithHostname:kHostName];
        
        __weak NSOperationQueue *operationQueue = _operationQueue;
        _reachable.reachableBlock = ^(Reachability *reach) {
            [operationQueue setSuspended:NO];
        };
        _reachable.unreachableBlock = ^(Reachability *reach) {
            [operationQueue setSuspended:YES];
        };
        
        [_reachable startNotifier];
    }
    return self;
}

- (void)get:(NSString *)path callback:(void (^)(id))handler
{
    path = [path stringByAppendingString:@".json"];
    
    NSURL *url = [_baseUrl URLByAppendingPathComponent:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:_operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSArray *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        handler(dict);
    }];
}

@end
