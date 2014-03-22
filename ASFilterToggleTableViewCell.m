//
//  ASFilterToggleTableViewCell.m
//  YelpSearch
//
//  Created by Alexander Seville on 3/22/14.
//  Copyright (c) 2014 Alexander Seville. All rights reserved.
//

#import "ASFilterToggleTableViewCell.h"

@interface ASFilterToggleTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *visibleView;

@end

@implementation ASFilterToggleTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    //_visibleView.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
