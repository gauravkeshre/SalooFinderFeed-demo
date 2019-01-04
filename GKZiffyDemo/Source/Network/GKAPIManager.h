//
//  GKAPIManager.h
//  GKZiffyDemo
//
//  Created by Gaurav Keshre on 6/27/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GKHTTPRequester.h"
@interface GKAPIManager : NSObject

+(void)findAllBusinessesWithQuery:(NSString*)q
                       fromOffset:(NSInteger )offset
                           cityID:(NSString *)city
                           vertical:(NSString *)v
                     withCallback:(GKSuccessCallback)success_callback
                        onFailure:(GKFailureCallback)failure_callback;

+ (void) getlocalDataAtPage:(NSInteger)page withCallback:(GKSuccessCallback)success_callback;
//+(NSString*)urlAtIndex:(NSInteger)index;
@end
