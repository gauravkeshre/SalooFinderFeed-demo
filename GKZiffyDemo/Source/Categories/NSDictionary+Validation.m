//
//  NSDictionary+Validation.m
//  GKZiffyDemo
//
//  Created by Gaurav Keshre on 6/27/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import "NSDictionary+Validation.h"

@implementation NSDictionary (Validation)

-(BOOL) isValid{
    return !((self == nil) || ([self isEqual:[NSNull null]]));

}
-(id)escapedValueForKey:(NSString *)key{
    if (![self[key] isKindOfClass:[NSString class]]) {
        return self[key];
    }
    NSString *v = [self[key] stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    return v;
}
@end
