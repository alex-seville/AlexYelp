//
//  ASFilterSection.h
//  YelpSearch
//
//  Created by Alexander Seville on 3/24/14.
//  Copyright (c) 2014 Alexander Seville. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASFilterSection : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *apiField;
@property (nonatomic, strong) NSMutableArray *filterList;

@end
