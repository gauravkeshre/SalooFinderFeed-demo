//
//  NSString+Highlights.h
//  GKZiffyDemo
//
//  Created by Gaurav Keshre on 6/29/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Highlights)
+(NSAttributedString *)hightlightComponentsAtIndices:(NSArray *)arrayOfIndices fromStringwithComponents:(NSArray *)arrayOfComponents;
@end
