//
//  GKAppearanceManager.m
//  GKZiffyDemo
//
//  Created by Gaurav Keshre on 6/29/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import "GKAppearanceManager.h"
#import "SVProgressHUD.h"
#import "UIColor+AppTheme.h"
@implementation GKAppearanceManager

+(void)applyAppearance{
    /*
     * All APpearance proxy related stuffs here
     */
    
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor appLightBlueColor]];

}
@end
