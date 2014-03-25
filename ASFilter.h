//
//  ASFilter.h
//  YelpSearch
//
//  Created by Alexander Seville on 3/23/14.
//  Copyright (c) 2014 Alexander Seville. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASFilter : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *apiValue;
@property (nonatomic, assign) BOOL state;


@end
