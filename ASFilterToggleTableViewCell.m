//
//  ASFilterToggleTableViewCell.m
//  YelpSearch
//
//  Created by Alexander Seville on 3/22/14.
//  Copyright (c) 2014 Alexander Seville. All rights reserved.
//

#import "ASFilterToggleTableViewCell.h"
#import "ASFilter.h"

@interface ASFilterToggleTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *filterNameLabel;
@property (weak, nonatomic) IBOutlet UISwitch *filterState;

@end

@implementation ASFilterToggleTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



#pragma mark - Public methods


- (void)setFilterObj:(ASFilter *)filter {
    self.filterNameLabel.text = filter.name;
}

@end
