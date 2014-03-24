//
//  ASBusiness.m
//  YelpSearch
//
//  Created by Alexander Seville on 3/20/14.
//  Copyright (c) 2014 Alexander Seville. All rights reserved.
//

#import "ASBusiness.h"

@implementation ASBusiness

- (id)initWithBusinessData:(NSDictionary *)businessData {
    
    self = [super init];
        
    self.name = [businessData objectForKey:@"name"];
    self.reviewCount = [[businessData objectForKey:@"review_count"] integerValue];
    self.ratingImageURL = [businessData objectForKey:@"rating_img_url_large"];
    /* this may be troublesome */
    //parsedBusiness.distance
        
    /* we don't have this */
    //parsedBusiness.price
        
            
    /* parse location */
    NSDictionary *location = [businessData objectForKey:@"location"];
    self.address = [[location objectForKey:@"address"] componentsJoinedByString:@", "];
    self.address = [self.address stringByAppendingString:@", "];
    self.address = [self.address stringByAppendingString:[[location objectForKey:@"neighborhoods"] componentsJoinedByString:@", "]];
        
    self.categories = [businessData objectForKey:@"categories"];
        
        
    self.imageURL = [businessData objectForKey:@"image_url"];
        
    
    return self;
}

- (NSString *) getCategoriesString {
    
    NSString *categoryString = @"";
    
    for (int i = 0; i < self.categories.count; i++) {
        if (i == 0) {
            categoryString = self.categories[i][0];
        }
        else {
            categoryString = [categoryString stringByAppendingFormat:@", %@", self.categories[i][0]];
        }
    }
    
    return categoryString;
}

@end

