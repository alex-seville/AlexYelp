//
//  ASResultListTableCell.h
//  YelpSearch
//
//  Created by Alexander Seville on 3/20/14.
//  Copyright (c) 2014 Alexander Seville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASBusiness.h"

@interface ASResultListTableCell : UITableViewCell

- (void) setBusinessToCell:(ASBusiness *)business withIndex:(NSInteger)index;

+ (NSString *)renderBusinessName:(NSString *)businessName withIndex:(NSInteger)index;

@end
