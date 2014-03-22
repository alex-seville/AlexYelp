//
//  ASFilterMultiSelectTableViewCell.m
//  YelpSearch
//
//  Created by Alexander Seville on 3/22/14.
//  Copyright (c) 2014 Alexander Seville. All rights reserved.
//

#import "ASFilterMultiSelectTableViewCell.h"

@interface ASFilterMultiSelectTableViewCell()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentCOntrol;
@end

@implementation ASFilterMultiSelectTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    _segmentCOntrol.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
