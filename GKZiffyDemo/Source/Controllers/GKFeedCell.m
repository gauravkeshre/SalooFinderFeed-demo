//
//  GKFeedCell.m
//  GKZiffyDemo
//
//  Created by Gaurav Keshre on 6/28/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import "GKFeedCell.h"
#import "DYRateView.h"
#import "UIImageView+LazyLoading.h"
#import "GKAPIManager.h"
#import "NSString+Highlights.h"

static NSInteger TEMP;
@interface GKFeedCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgPreview;

@property (weak, nonatomic) IBOutlet UITextView *txtAddress;

@property (weak, nonatomic) IBOutlet UILabel *lblPriceSummary;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;

@property (weak, nonatomic) IBOutlet DYRateView *ratingView;
@property (weak, nonatomic) IBOutlet UILabel *lblBusinessName;

- (IBAction)handleBookNowAction:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *lblBusinessType; //type

@end

@implementation GKFeedCell

-(void)awakeFromNib{
    [super awakeFromNib];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2, 2);
    self.layer.shadowRadius = 22.f;
    self.layer.cornerRadius = 4.f;
    

    /*
     * configure RatingView
     * tried doing this as runtime attributes in storyboard but this crashes the xcdode. Wierd !
     */
        [self.ratingView setFullStarImage:[UIImage imageNamed:@"star_fill"]];
        [self.ratingView setEmptyStarImage:[UIImage imageNamed:@"star_empty"]];
        [self.ratingView setAlignment:RateViewAlignmentLeft];
        [self.ratingView setEditable:NO];
}

- (void) setData:(id)data{
//    [self.imgPreview setImageWithURL:[NSURL URLWithString:data[@"image"]] scale:0.5 usingSession:[GKAPIManager sharedSession]];
//
    //[self.contentView sendSubviewToBack:self.imgPreview];
    /*
     * Type
     */
    
    [self.lblBusinessType setText:data[@"type"]];
    
    /*
     * Rating
     */
    CGFloat rate = [data[@"rating"] floatValue];
    [self.ratingView setRate:rate];
    
    /*
     * Name
     */
    
    [self.lblBusinessName setText:data[@"name"]];
    
    
    /*
     * Price
     */
    //TODO: This string formation must be cached and used the next time instead of doing this everytime for a record.
    
    NSAttributedString *priceSummary = [NSString hightlightComponentsAtIndices:@[@(1)] fromStringwithComponents:@[@"₹", [NSString stringWithFormat:@"%li", (long)[data[@"fees_min"] integerValue]], @"for", data[@"fees_min_service"]]];
    [self.lblPriceSummary setAttributedText:priceSummary];
    
    
    /*
     * TextView
     */
    [self.txtAddress setText:data[@"address"]];
//    CGRect fr = self.txtAddress.frame;
//    CGSize size = [self.txtAddress sizeThatFits:CGSizeMake(fr.size.width, FLT_MAX)];
//    if (size.height > fr.size.height) {
//        fr.size.width += 30.f;
//        self.txtAddress.frame = fr;
//    }
    

    
    /*
     * Distance
     */
    //TODO: calculate the distance in the backend and get the
    
    NSString *strDistance = [NSString stringWithFormat:@"%i", arc4random()%20];
    NSAttributedString *distance = [NSString hightlightComponentsAtIndices:@[@(0)] fromStringwithComponents:@[strDistance, @"km"]];
    [self.lblDistance setAttributedText:distance];
    
    
    TEMP++;
}
- (IBAction)handleBookNowAction:(id)sender {
}
@end
