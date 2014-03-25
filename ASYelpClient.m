//
//  ASYelpClient.m
//  YelpSearch
//
//  Created by Alexander Seville on 3/21/14.
//  Copyright (c) 2014 Alexander Seville. All rights reserved.
//

/* Borrowed from Tim Lee - https://github.com/thecodepath/ios_yelp */

#import "ASYelpClient.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ASFilter.h"
#import "ASFilterSection.h"

@implementation ASYelpClient

- (id)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret {
    NSURL *baseURL = [NSURL URLWithString:@"http://api.yelp.com/v2/"];
    self = [super initWithBaseURL:baseURL consumerKey:consumerKey consumerSecret:consumerSecret];
    if (self) {
        BDBOAuthToken *token = [BDBOAuthToken tokenWithToken:accessToken secret:accessSecret expiration:nil];
        [self.requestSerializer saveAccessToken:token];
    }
    return self;
}

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term filters:(NSArray *)filters success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters addEntriesFromDictionary:@{@"term": term, @"location" : @"San Francisco"}];
    
    /* loop through the filters and apply any on values as search filters */
    for(ASFilterSection *filterSection in filters){
        for(ASFilter *filter in filterSection.filterList){
            if (filter.state && ![filter.apiValue isEqual:@""]){
                if (parameters[filterSection.apiField]){
                    [parameters[filterSection.apiField] stringByAppendingString:[@"," stringByAppendingString:filter.apiValue]];
                }else{
                    [parameters addEntriesFromDictionary:@{filterSection.apiField: filter.apiValue}];
                }
            }
        }
    }
    NSLog(@"parameters: %@", parameters);
    
    return [self GET:@"search" parameters:parameters success:success failure:failure];
}

/* should be in the model, but no time to refactor now */
- (NSArray *)getFilterSections {
    NSMutableArray *filterSections = [[NSMutableArray alloc] init];
    
    /* based on sample by Nick Halper */
    NSMutableArray *categoryConfig = [NSMutableArray arrayWithObjects:
                                      @{
                                        @"name": @"Features",
                                        @"apiField": @"deals_filter",
                                        @"list": @[
                                                @[@"Offering a Deal", @(YES), @(NO)]
                                            ]
                                        },
                                      @{
                                        @"name": @"Distance",
                                        @"apiField": @"radius_filter",
                                        @"list": @[
                                                @[@"Auto", @"", @(YES)],
                                                @[@"2 blocks", @(160), @(NO)],
                                                @[@"6 blocks", @(482), @(NO)],
                                                @[@"1 mile", @(1609), @(NO)],
                                                @[@"5 miles", @(8046), @(NO)]
                                            ]
                                        },
                                      @{
                                        @"name": @"Sort By",
                                        @"apiField": @"sort",
                                        @"list": @[
                                                @[@"Best Match", @(0), @(YES)],
                                                @[@"Distance",  @(1), @(NO)],
                                                @[@"Rating",  @(2), @(NO)]
                                            ]
                                        },
                                      @{
                                        @"name": @"Categories",
                                        @"apiField": @"category_filter",
                                        @"list": @[
                                                @[@"Buffets", @"buffets", @(NO)],
                                                @[@"Cafes", @"cafes", @(NO)],
                                                @[@"Burgers", @"burgers", @(NO)],
                                                @[@"Show All", @"", @(NO)],
                                                @[@"Delis", @"delis", @(NO)],
                                                @[@"Diners", @"diners", @(NO)],
                                                @[@"Halal", @"halal", @(NO)],
                                                @[@"Salad", @"salad", @(NO)],
                                                @[@"Soup", @"soup", @(NO)],
                                                @[@"Vegan", @"vegan", @(NO)]
                                            ]
                                        },
                                      nil];
    
    for (NSDictionary *category in categoryConfig){
        ASFilterSection *filterSection = [[ASFilterSection alloc] init];
        NSMutableArray *filters = [[NSMutableArray alloc] init];
        for (NSArray *filterDetail in category[@"list"]){
            ASFilter *newFilter = [[ASFilter alloc] init];
            newFilter.name = filterDetail[0];
            newFilter.apiValue = filterDetail[1];
            newFilter.state = [filterDetail[2] boolValue];
            [filters addObject:newFilter];
        }
        filterSection.name = category[@"name"];
        filterSection.apiField = category[@"apiField"];
        filterSection.filterList = filters;
        [filterSections addObject: filterSection];
    }
    return filterSections;
}

@end
