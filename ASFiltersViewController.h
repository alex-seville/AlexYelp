//
//  ASFiltersViewController.h
//  YelpSearch
//
//  Created by Alexander Seville on 3/22/14.
//  Copyright (c) 2014 Alexander Seville. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASFiltersViewController;

@protocol ASFiltersViewControllerDelegate <NSObject>
- (void)addItemViewController:(ASFiltersViewController *)controller didChangeFilters:(NSArray *)filterSectionList;
@end


@interface ASFiltersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSArray *filterSectionsList;
@property (nonatomic, weak) id <ASFiltersViewControllerDelegate> delegate;

@end
