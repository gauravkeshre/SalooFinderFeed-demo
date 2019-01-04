//
//  GKHTTPRequesterClass.m
//  GKZiffyDemo
//
//  Created by Gaurav Keshre on 6/27/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import "GKHTTPRequester.h"
#import "NSDictionary+Validation.h"

@implementation GKHTTPRequester

-(void)dealloc{
    [self.dataTask cancel];
    [[self session] finishTasksAndInvalidate];
    self.dataTask = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = GKHTTPMethodPOST;
    }
    return self;
}

#pragma mark - Session Getter Methods
- (NSURLSession *)session{
    static NSURLSession *_session;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    });
    return _session;
}

#pragma mark - NSURLSession Methods

-(void)handleResponseWithCallback:(GKSuccessCallback)callback
                             data:(NSData *)data response:(NSURLResponse *)response
                            error: (NSError *)error{
    if(error){
        callback(NO,@{@"message":[error userInfo][@"NSLocalizedDescription"]});
        return;
    }
    
    NSMutableDictionary *responsDic = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error]];
    
    if (responsDic.isValid) {
        callback(YES, responsDic);
        
    }else{
        callback(NO, nil);
    }
}


-(void) invokeURL:(NSString *)serviceURL
       withParams:(NSDictionary *)params
                       callback:(GKSuccessCallback)callback{
       NSURL *url = [NSURL URLWithString:serviceURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                           timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    
    NSError *error;
    // Set the request's content type to application/x-www-form-urlencoded
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

//    NSData *data = [NSJSONSerialization dataWithJSONObject:params
//                                                   options:kNilOptions
//                                                     error:&error];
//    [request setHTTPBody:data];
    NSMutableString *strBody = [NSMutableString new];
    
    for (NSString *key in params) {
        [strBody appendFormat:@"%@=%@&", key, [params escapedValueForKey:key]];
    }
    
    
    
    NSData *nData = [NSData dataWithBytes:[strBody UTF8String] length:strlen([strBody UTF8String])];
    
    [request setHTTPBody:nData];

    NSOperationQueue *queue = [NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                           [self handleResponseWithCallback:callback
                                                                       data:data
                                                                   response:response error:error];
                                           
                                       }];
}

-(void) __invokeURL:(NSString *)serviceURL
       withParams:(NSDictionary *)params
         callback:(GKSuccessCallback)callback{
   NSURL *url = [NSURL URLWithString:serviceURL];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                           timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    
    NSError *error;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:params
                                                   options:kNilOptions
                                                     error:&error];
    [request setHTTPBody:data];
    NSURLSessionDataTask *task1 = [[self session]dataTaskWithRequest:request
                                                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                       [self handleResponseWithCallback:callback
                                                                                   data:data
                                                                               response:response error:error];
                                                   }];

    [task1 resume];
}

//-(void) _invokeURL:(NSString *)serviceURL
//               withParams:(NSDictionary *)params
//                 callback:(GKSuccessCallback)callback{
//
//    NSURL *url = [NSURL URLWithString:serviceURL];
//    
//    
//    
//    
//    
//    
//    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
//      [urlRequest setHTTPMethod:@"POST"];
//    [urlRequest setHTTPBody:[strParams dataUsingEncoding:NSUTF8StringEncoding]];
//    NSURLSessionDataTask *task = [[self session] dataTaskWithRequest:urlRequest
//                                                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                                                       if(error){
//                                                           callback(NO,@{@"message":[error userInfo][@"NSLocalizedDescription"]});
//                                                           return;
//                                                       }
//                                                       
//                                                       NSMutableDictionary *responsDic = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error]];
//                                                    
//                                                       if (responsDic.isValid && [responsDic[kSTATUS] isValid]) {
//                                                           callback([responsDic[kSTATUS] boolValue], responsDic);
//
//                                                       }else{
//                                                           callback(NO, nil);
//                                                       }
//                                                       
//                                                   }];
//    [task resume];
//}

-(void)cancelAllServices{
    [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
        [self.dataTask cancel];
        [[self session] finishTasksAndInvalidate];
}

#pragma mark - Session Delegate
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session{
    NSLog(@"completed");
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest *))completionHandler{
    
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error{
    NSLog(@"%s", __FUNCTION__);
}

@end
