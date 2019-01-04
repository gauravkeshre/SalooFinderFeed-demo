//
//  UIImageView+LazyLoading.h
//  GKZiffyDemo
//
//  Created by Gaurav Keshre on 6/29/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LazyLoading)
-(void)setImageWithURL:(NSURL*)imageURL scale:(CGFloat)scale usingSession:(NSURLSession*)session;

- (void)loadImageWithURL:(NSString *)path
        withPlaceHoldetImage:(UIImage *)placeholderImage
        errorImage:(UIImage *)errorImage;

@end
