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
- (IBAction)filterStateAction:(id)sender;

@end

@implementation ASFilterToggleTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    
    // Configure the view for the selected state
}

- (IBAction)filterStateAction:(id)sender {
    
    self.filterObj.state = self.filterState.on;
    
}



#pragma mark - Public methods


- (void)setFilterObj:(ASFilter *)filter {
    _filterObj = filter;
    self.filterNameLabel.text = filter.name;
    [self.filterState setOn:filter.state];
    
}


@end
