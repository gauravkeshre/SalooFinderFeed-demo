//
//  GKFeedCVC.m
//  GKZiffyDemo
//
//  Created by Gaurav Keshre on 6/28/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import "GKFeedCVC.h"
#import "GKAPIManager.h"
#import "GKFeedDataSource.h"
#import "GKFeedFlowLayout.h"
#import "SVProgressHUD.h"

@interface GKFeedCVC()<UICollectionViewDelegateFlowLayout>{
    NSUInteger pageOffset;
}
@property (strong, nonatomic)NSDictionary *feedData;
@property (strong, nonatomic)GKFeedDataSource *dataSource;
@end

@implementation GKFeedCVC
#pragma mark - Lifecycle Methods

-(void)viewDidLoad{
    

    _dataSource = [[GKFeedDataSource alloc]initWithCollectionView:self];

    self.collectionView.dataSource = self.dataSource;
    [self fetchDataAtPage:pageOffset];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
        [self.collectionView.collectionViewLayout invalidateLayout];
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row>= self.dataSource.arrFeed.count-2) {
        [self fetchDataAtPage:pageOffset];
    }
    
}


#pragma mark - Data
#define kQueryString @"Hair Spa"
#define kCityID @"4"
#define kVertical @"salons-spas"

//TODO:-  Remove the code to get local data and include the call to methdo that gives data from webservice
-(void)temp_fetchDataAtPage:(NSInteger)page{
    if (page >4) {
        return;
    }
    GKFeedCVC *__weak _weakSelf = self;
    [GKAPIManager getlocalDataAtPage:page
                        withCallback:^(BOOL success, id result) {
        if (success) {
            pageOffset++;
            [_weakSelf.dataSource appendData:result[@"results"] reload:(page==0)];
        }
    }];

}

-(void)fetchDataAtPage:(NSInteger)page{
    [SVProgressHUD showWithStatus:@"Getting more data..." maskType:SVProgressHUDMaskTypeClear];;
    [GKAPIManager findAllBusinessesWithQuery:kQueryString
                                  fromOffset:page
                                      cityID:kCityID vertical:kVertical withCallback:^(BOOL success, id result) {
                                          [SVProgressHUD dismiss];
                                          pageOffset++;
                                          [self.dataSource appendData:result[@"results"] reload:NO];
                                      } onFailure:^(NSString *error_code, NSString *message) {
                                          [SVProgressHUD showErrorWithStatus:message];
                                          
                                          NSLog(@"%@", message);
                                         // [SVProgressHUD showErrorWithStatus:message];
                                      }];
}

#pragma mark - TEMP

-(void)showHUD{
    UIView *v = [[UIView alloc]initWithFrame:self.view.bounds];
    v.alpha = 0.5;
    v.tag = 1025;
    [v setBackgroundColor:[UIColor colorWithRed:0.110 green:0.671 blue:0.663 alpha:1.000]];
    [self.view addSubview:v];

    v= nil;
}

-(void)hideHUD{
    [[self.view viewWithTag:1025] removeFromSuperview];
}
@end
