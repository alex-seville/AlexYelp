//
//  ASFilterExpandableTableViewCell.h
//  YelpSearch
//
//  Created by Alexander Seville on 3/22/14.
//  Copyright (c) 2014 Alexander Seville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASFilter.h"

@interface ASFilterExpandableTableViewCell : UITableViewCell

@property (nonatomic, strong) ASFilter *filterObj;
@property (nonatomic, assign) BOOL expanded;

@end
