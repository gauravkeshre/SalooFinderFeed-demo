//
//  GKFeedDataSource.m
//  GKZiffyDemo
//
//  Created by Gaurav Keshre on 6/28/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import "GKFeedDataSource.h"
#import "GKFeedCell.h"
@interface GKFeedDataSource()
    @property (strong, nonatomic)NSMutableArray *arrFeed;
    @property (weak, nonatomic)UICollectionViewController
*controller;
@end
@implementation GKFeedDataSource

-(instancetype)initWithCollectionView:(UICollectionViewController *)cvc{
    self = [super init];
    if (self) {
        self.controller = cvc;
        self.arrFeed = [[NSMutableArray alloc]initWithCapacity:10];
    }
    return self;
}

#pragma mark -  Methods
-(void)reloadWithData:(NSArray *)arr{
    [self.arrFeed addObjectsFromArray:arr];
    [self.controller.collectionView reloadData];
}
- (void)appendData:(NSArray *) array reload:(BOOL)shouldReload{
    if (shouldReload) {
        [self.arrFeed removeAllObjects];
        [self.arrFeed addObjectsFromArray:array];
        [self.controller.collectionView reloadData];
        return;
    }

    NSUInteger oldCount = [self.arrFeed count]; //data is the previous array of data
    
    if (self.arrFeed == nil) {
        self.arrFeed = [[NSMutableArray alloc]initWithArray:array];
    }else{
        [self.arrFeed addObjectsFromArray:array];
    }
    
    NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
    
    for (NSInteger i = oldCount; i < self.arrFeed.count; i++) {
        [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow:i
                                                          inSection:0]];
    }
    [self.controller.collectionView performBatchUpdates:^{
        [self.controller.collectionView insertItemsAtIndexPaths:arrayWithIndexPaths];
    } completion:nil];
}
#pragma mark - UICollectionViewDataSource Methods
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrFeed.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GKFeedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GKFeedCell" forIndexPath:indexPath];
    [cell setData:self.arrFeed[indexPath.row]];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SearchHeaderReusable" forIndexPath:indexPath];
    
}
@end
