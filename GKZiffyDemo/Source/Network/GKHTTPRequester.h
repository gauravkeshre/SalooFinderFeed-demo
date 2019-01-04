//
//  GKHTTPRequesterClass.h
//  GKZiffyDemo
//
//  Created by Gaurav Keshre on 6/27/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define  kMESSAGE   @"message"
#define  kSTATUS    @"status"
typedef NS_ENUM(NSUInteger, GKHTTPMethod) {
    GKHTTPMethodGET,
    GKHTTPMethodPOST
};

typedef void (^GKProgressCallback) (CGFloat progress);
typedef void (^GKSuccessCallback)  (BOOL success, id result);
typedef void (^GKFailureCallback)  (NSString *error_code, NSString *message);


@interface GKHTTPRequester : NSObject <NSURLSessionDelegate>

@property (nonatomic, assign) GKHTTPMethod method;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

-(void) invokeURL:(NSString *)serviceURL
       withParams:(NSDictionary *)params
         callback:(GKSuccessCallback)callback;

-(void)cancelAllServices;
@end
