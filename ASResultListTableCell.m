//
//  ASResultListTableCell.m
//  YelpSearch
//
//  Created by Alexander Seville on 3/20/14.
//  Copyright (c) 2014 Alexander Seville. All rights reserved.
//

#import "ASResultListTableCell.h"
#import "UIImageView+AFNetworking.h"
#import "ASBusiness.h"

@interface ASResultListTableCell()
@property (weak, nonatomic) IBOutlet UILabel *businessNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoriesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *businessImage;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImage;

@property (nonatomic, strong) ASBusiness *business;

@end

@implementation ASResultListTableCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.businessNameLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.businessNameLabel.frame);
    
    self.businessImage.layer.masksToBounds = YES;
    self.businessImage.layer.cornerRadius = 5.0;
}

#pragma mark public methods

- (void) setBusinessToCell:(ASBusiness *)business withIndex:(NSInteger)index {
    _business = business;

    self.businessNameLabel.text = [NSString stringWithFormat: @"%i. %@", index, business.name];
    self.distanceLabel.text = [NSString stringWithFormat: @"%.2fmi", business.distance];
    self.priceLabel.text = [@"" stringByPaddingToLength:business.price withString:@"$" startingAtIndex:0];
    self.reviewCountLabel.text = [NSString stringWithFormat:@"%i Reviews", business.reviewCount];
    self.businessAddressLabel.text = business.address;
    
    self.categoriesLabel.text = [business getCategoriesString];
    [self.businessImage setImageWithURL:[NSURL URLWithString:business.imageURL]];
    [self.ratingImage setImageWithURL:[NSURL URLWithString:business.ratingImageURL]];
}


@end
