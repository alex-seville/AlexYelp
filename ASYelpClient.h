//
//  ASYelpClient.h
//  YelpSearch
//
//  Created by Alexander Seville on 3/21/14.
//  Copyright (c) 2014 Alexander Seville. All rights reserved.
//


/* Borrowed from Tim Lee - https://github.com/thecodepath/ios_yelp */

#import <UIKit/UIKit.h>
#import "BDBOAuth1RequestOperationManager.h"

@interface ASYelpClient : BDBOAuth1RequestOperationManager

- (id)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret;

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end