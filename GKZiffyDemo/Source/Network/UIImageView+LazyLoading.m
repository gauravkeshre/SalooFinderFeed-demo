//
//  UIImageView+LazyLoading.m
//  GKZiffyDemo
//
//  Created by Gaurav Keshre on 6/29/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import "UIImageView+LazyLoading.h"
#import <objc/runtime.h>

static char kGKSessionDataTaskKey;

@implementation UIImageView (LazyLoading)
-(void)setDataTask:(NSURLSessionDataTask*)dataTask
{
    objc_setAssociatedObject(self, &kGKSessionDataTaskKey, dataTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSURLSessionDataTask*)dataTask
{
    return (NSURLSessionDataTask *)objc_getAssociatedObject(self, &kGKSessionDataTaskKey);
}

-(void)setImageWithURL:(NSURL*)imageURL scale:(CGFloat)scale usingSession:(NSURLSession*)session
{
    if (self.dataTask) {
        [self.dataTask cancel];
    }
    
    if (imageURL) {
        __weak typeof(self) weakSelf = self;
        self.dataTask = [session dataTaskWithURL:imageURL
                               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                   __strong __typeof(weakSelf) strongSelf = weakSelf;
                                   if (error) {
                                       NSLog(@"ERROR: %@", error);
                                   }
                                   else {
                                       NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
                                       if (200 == httpResponse.statusCode) {
                                           UIImage * image = [UIImage imageWithData:data];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               strongSelf.image = image;
                                           });
                                       } else {
                                           NSLog(@"Couldn't load image at URL: %@", imageURL);
                                           NSLog(@"HTTP %ld", (long)httpResponse.statusCode);
                                           
                                           [self setImage:[UIImage imageNamed:@"default"]];
                                       }
                                   }
                               }];
        [self.dataTask resume];
    }
    return;
}


- (void)loadImageWithURL:(NSString *)path
    withPlaceHoldetImage:(UIImage *)placeholderImage
              errorImage:(UIImage *)errorImage{
    if (placeholderImage) {
        self.image = placeholderImage;
    }
    
    NSURL *url = [NSURL URLWithString:path];
    if (!url && errorImage) {
        self.image = errorImage; return;
    }
    
    
    
    
    
    
    
}
@end
