//
//  UIColor+AppTheme.m
//  GKZiffyDemo
//
//  Created by Gaurav Keshre on 6/27/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import "UIColor+AppTheme.h"

@implementation UIColor (AppTheme)
+(UIColor *)appLightBlueColor{
    return [UIColor colorWithRed:0.333 green:0.776 blue:0.769 alpha:1.000];
}
+(UIColor *)appDarkBlueColor{
    return [UIColor colorWithRed:0.110 green:0.671 blue:0.663 alpha:1.000];
}
+(UIColor *)appBarColor{
    return [UIColor colorWithRed:0.039 green:0.098 blue:0.161 alpha:1.000];
}
+(UIColor *)appRed{
    return [UIColor colorWithRed:0.851 green:0.004 blue:0.255 alpha:1.000]
    ;
}

+(UIColor *)appLightGrey{
    return [UIColor colorWithRed:0.878 green:0.882 blue:0.890 alpha:1.000];
}



@end
