//
//  ASFilterExpandableTableViewCell.m
//  YelpSearch
//
//  Created by Alexander Seville on 3/22/14.
//  Copyright (c) 2014 Alexander Seville. All rights reserved.
//

#import "ASFilterExpandableTableViewCell.h"
#import "ASFilter.h"

@interface ASFilterExpandableTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *filterNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *filterState;
@end

@implementation ASFilterExpandableTableViewCell

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


- (void)setFilterObj:(ASFilter *)filter {
    self.filterNameLabel.text = filter.name;
}

- (void)setExpanded:(BOOL)expanded {
    self.filterState.titleLabel.text = expanded ? @"•" : @">";
}

@end
