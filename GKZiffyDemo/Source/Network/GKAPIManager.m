//
//  GKAPIManager.m
//  GKZiffyDemo
//
//  Created by Gaurav Keshre on 6/27/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import "GKAPIManager.h"
#import "GKHTTPRequester.h"
#import "APIConstants.h"
#import "NSDictionary+Validation.h"

@interface GKAPIManager ()
    @property (strong, nonatomic)GKHTTPRequester *requester;
@end

@implementation GKAPIManager


+(instancetype)instance{
    static GKAPIManager *instance;
static dispatch_once_t onceToken;
dispatch_once(&onceToken, ^{
    instance = [GKAPIManager new];
});
    return instance;
}

-(void)dealloc{
    _requester = nil;

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _requester = [GKHTTPRequester new];
        [_requester setMethod:GKHTTPMethodPOST];
    }
    return self;
}


#pragma mark - Instnace Methods

-(void)findAllBusinessesWithQuery:(NSString*)q
                       fromOffset:(NSInteger )page_no
                           cityID:(NSString *)city
                         vertical:(NSString *)v
                     withCallback:(GKSuccessCallback)success_callback
                        onFailure:(GKFailureCallback)failure_callback{

[self.requester invokeURL:API_URL(ACTION_SEARCH) withParams:API_SEARCH_PARAMS(city, v, q, @(page_no)) callback:^(BOOL success, id result) {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (success && success_callback) {
            success_callback(YES, result);
        }else if (failure_callback){
            failure_callback(@"Some error occured", result);
        }
    });
   
}];
    
}


#pragma mark - Public Methods

+(void)findAllBusinessesWithQuery:(NSString*)q
                       fromOffset:(NSInteger )offset
                           cityID:(NSString *)city
                         vertical:(NSString *)v
                     withCallback:(GKSuccessCallback)success_callback
                        onFailure:(GKFailureCallback)failure_callback{
    [[GKAPIManager instance] findAllBusinessesWithQuery:q fromOffset:offset
                                                 cityID:city
                                               vertical:v withCallback:success_callback onFailure:failure_callback];
}


//TODO: TO remove thesem methods and load the data from web api.
#pragma mark - Temporary Methods 

+ (void) getlocalDataAtPage:(NSInteger)page withCallback:(GKSuccessCallback)success_callback{
    
    NSString *name = [NSString stringWithFormat:@"sample_data_source_page%li", (long)page%3];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    
    NSDictionary *jsonDataArray = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    
    success_callback (YES, jsonDataArray);
}


//+(NSString*)urlAtIndex:(NSInteger)index{
////    return @[URL_page0, URL_page1, URL_page2][index%3];
//}

@end
