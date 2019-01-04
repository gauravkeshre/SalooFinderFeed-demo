//
//  NSDictionary+Validation.h
//  GKZiffyDemo
//
//  Created by Gaurav Keshre on 6/27/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Validation)
-(BOOL) isValid;
-(NSString *)escapedValueForKey:(NSString *)key;
@end
