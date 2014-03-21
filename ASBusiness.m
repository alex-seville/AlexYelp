//
//  ASBusiness.m
//  YelpSearch
//
//  Created by Alexander Seville on 3/20/14.
//  Copyright (c) 2014 Alexander Seville. All rights reserved.
//

#import "ASBusiness.h"

@implementation ASBusiness

- (NSString *) getCategoriesString {
    return [self.categories componentsJoinedByString:@", "];
}

@end

