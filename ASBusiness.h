//
//  ASBusiness.h
//  YelpSearch
//
//  Created by Alexander Seville on 3/20/14.
//  Copyright (c) 2014 Alexander Seville. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASBusiness : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, assign) NSInteger reviewCount;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *ratingImageURL;

- (NSString *) getCategoriesString;
- (id)initWithBusinessData:(NSDictionary *)businessData;

@end

