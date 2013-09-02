//
//  UBRequest.m
//  Unison Brain
//
//  Created by Kyle Warren on 2/10/13.
//  Copyright (c) 2013 Kyle Warren. All rights reserved.
//

#import "UBRequest.h"

#import "UBUser.h"
#import "Reachability.h"

#ifdef DEBUG
#define kHostName @"http://localhost:3000"
#else
#define kHostName @"http://unison.herokuapp.com"
#endif

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

+ (void)get:(NSString *)path callback:(void (^)(id))handler failure:(void (^)(id))failure
{
    [[self ubr] get:path callback:handler failure:failure];
}

+ (void)post:(NSString *)path data:(NSDictionary *)dataDict callback:(void (^)(id))handler failure:(void (^)(id))failure
{
    [[self ubr] post:path data:dataDict callback:handler failure:failure];
}

+ (void)put:(NSString *)path data:(NSDictionary *)dataDict callback:(void (^)(id))handler failure:(void (^)(id))failure
{
    [[self ubr] put:path data:dataDict callback:handler failure:failure];
}

+ (void)destroy:(NSString *)path callback:(void (^)(id))handler failure:(void (^)(id))failure
{
    [[self ubr] destroy:path callback:handler failure:failure];
}

+ (void)get:(NSString *)path callback:(void (^)(id))handler
{
    [[self ubr] get:path callback:handler failure:nil];
}

+ (void)post:(NSString *)path data:(NSDictionary *)dataDict callback:(void (^)(id))handler
{
    [[self ubr] post:path data:dataDict callback:handler failure:nil];
}

+ (void)put:(NSString *)path data:(NSDictionary *)dataDict callback:(void (^)(id))handler
{
    [[self ubr] put:path data:dataDict callback:handler failure:nil];
}

+ (void)destroy:(NSString *)path callback:(void (^)(id))handler
{
    [[self ubr] destroy:path callback:handler failure:nil];
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
        
        //[_reachable startNotifier];
    }
    return self;
}

// sugar methods

- (void)get:(NSString *)path callback:(void (^)(id))handler
{
    [self get:path callback:handler failure:nil];
}

- (void)post:(NSString *)path data:(NSDictionary *)dataDict callback:(void (^)(id))handler
{
    [self post:path data:dataDict callback:handler failure:nil];
}

- (void)put:(NSString *)path data:(NSDictionary *)dataDict callback:(void (^)(id))handler
{
    [self put:path data:dataDict callback:handler failure:nil];
}

- (void)destroy:(NSString *)path callback:(void (^)(id))handler
{
    [self destroy:path callback:handler failure:nil];
}

// methods

- (void)get:(NSString *)path callback:(void (^)(id))handler failure:(void (^)(id))failure
{
    [self request:path method:@"GET" data:nil callback:handler failure:failure];
}

- (void)post:(NSString *)path data:(NSDictionary *)dataDict callback:(void (^)(id))handler failure:(void (^)(id))failure
{
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dataDict options:0 error:&error];
    
    if (data == nil) {
        NSLog(@"Could not serialize dictionary for POST request. %@", dataDict);
        abort();
    }
    
    [self request:path method:@"POST" data:data callback:handler failure:failure];
}

- (void)put:(NSString *)path data:(NSDictionary *)dataDict callback:(void (^)(id))handler failure:(void (^)(id))failure
{
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dataDict options:0 error:&error];
    
    if (data == nil) {
        NSLog(@"Could not serialize dictionary for POST request. %@", dataDict);
        abort();
    }
    
    [self request:path method:@"PUT" data:data callback:handler failure:failure];
}

- (void)destroy:(NSString *)path callback:(void (^)(id))handler failure:(void (^)(id))failure
{
    [self request:path method:@"DELETE" data:nil callback:handler failure:failure];
}

- (void)request:(NSString *)path method:(NSString *)method data:(NSData *)data callback:(void (^)(id))callback failure:(void (^)(id))failure
{
    path = [path stringByAppendingString:@".json"];
    
    NSURL *url = [_baseUrl URLByAppendingPathComponent:path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = method;
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Token token=\"%@\"", [UBUser currentUser].token] forHTTPHeaderField:@"Authorization"];
    
    if (data != nil) {
        request.HTTPBody = data;
    }
    
    [NSURLConnection sendAsynchronousRequest:request queue:_operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        id jsonObject = nil;
        NSString *errorMsg = nil;
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        if (data == nil) {
            // not connected!
        }
        else {
            jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        }
        
        NSLog(@"json %@", jsonObject);
        
        if (httpResponse.statusCode > 399) {
            if (failure) {
                if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                    errorMsg = jsonObject[@"error"];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure(errorMsg);
                });
            }
        }
        else {
            if ([jsonObject isKindOfClass:[NSDictionary class]] || [jsonObject isKindOfClass:[NSArray class]]) {
                if ([jsonObject isKindOfClass:[NSDictionary class]] && jsonObject[@"error"] && [jsonObject[@"error"] isEqualToString:@"bad_token"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginExpiredNotifName object:nil];
                    });
                } else {
                    if (callback != nil) {
                        dispatch_async(dispatch_get_main_queue(), ^{ 
                            callback(jsonObject);
                        });
                    }
                }
            }
        }
    }];
}

@end
