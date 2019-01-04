//
//  GKFeedDataSource.h
//  GKZiffyDemo
//
//  Created by Gaurav Keshre on 6/28/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GKFeedDataSource : NSObject <UICollectionViewDataSource>

    @property (strong, nonatomic, readonly)NSMutableArray *arrFeed;

-(instancetype)initWithCollectionView:(UICollectionViewController *)cvc;

-(void)reloadWithData:(NSArray *)arr;
- (void)appendData:(NSArray *) array reload:(BOOL)shouldReload;

@end
