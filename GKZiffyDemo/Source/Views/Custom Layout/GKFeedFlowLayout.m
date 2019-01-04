//
//  GKFeedFlowLayout.m
//  GKZiffyDemo
//
//  Created by Gaurav Keshre on 6/26/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import "GKFeedFlowLayout.h"

#define MAX_COLUMNS  2
#define MIN_WIDTH 300.f
#define CELL_HEIGHT 310.f
@interface GKFeedFlowLayout()
{
    CGFloat cachedWidth;
}
@end

@implementation GKFeedFlowLayout
//(667 - 3*10)/2

- (void)prepareLayout{

    CGFloat cWidth = self.collectionView.frame.size.width;


    if (cachedWidth == cWidth ) {
        //just one layer of optimization as the item size is same for all cells
       // return;
    }
        NSUInteger columnCount = [self numberOfColumnsInWidth:cWidth];
        CGFloat padding = ((columnCount + 1) * self.sectionInset.left);
        CGFloat finalWidth = floorf((cWidth - padding)/columnCount) ;
        CGFloat calcWidth = MIN((cWidth - padding),finalWidth) ;
        self.itemSize  = CGSizeMake(calcWidth, 276 ); //114390/calcWidth
        cachedWidth = cWidth;
    

}

//-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
//    return YES;
//}
#pragma mark - CONV Methods

- (NSUInteger)numberOfColumnsInWidth:(CGFloat)cWidth{
    return MIN(floor(cWidth/MIN_WIDTH), MAX_COLUMNS);
}
@end
