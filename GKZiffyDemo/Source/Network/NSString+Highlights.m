//
//  NSString+Highlights.m
//  GKZiffyDemo
//
//  Created by Gaurav Keshre on 6/29/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NSString+Highlights.h"

@implementation NSString (Highlights)

+(NSAttributedString *)hightlightComponentsAtIndices:(NSArray *)arrayOfIndices fromStringwithComponents:(NSArray *)arrayOfComponents{

    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[arrayOfComponents componentsJoinedByString:@" "] attributes:nil];
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:17],
                                 NSForegroundColorAttributeName:[UIColor colorWithRed:0.110 green:0.671 blue:0.663 alpha:1.000]};

    for (NSNumber *index in arrayOfIndices ) {
        NSInteger i = [index integerValue];
        NSRange range = [[attr string] rangeOfString:arrayOfComponents[i]];
        [attr addAttributes:attributes
                      range:range];
    }
    return attr;
}
@end
