//
//  DataManager.m
//  TestGoEuro
//
//  Created by Macbook on 04/12/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import "DataManager.h"
#import "SearchData.h"
#import "Constants.h"

@implementation DataManager
+ (instancetype)sharedManager
{
    static DataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (NSArray *)parseResponse:(NSData*)responseData
{
    NSMutableArray* arrResults = [NSMutableArray array];
    if (responseData) {
        NSError* error;
        NSArray* jsonData = [NSJSONSerialization JSONObjectWithData:responseData
                                                                 options:kNilOptions
                                                                   error:&error];
        if (jsonData) {
            for (NSDictionary* dict in jsonData) {
                SearchData* searchData = [[SearchData alloc] init];
                searchData.departureTime = [dict objectForKey:@"departure_time"];
                searchData.arrivalTime = [dict objectForKey:@"arrival_time"];
                searchData.numberOfStops = [[dict objectForKey:@"number_of_stops"] intValue];
                NSString* strLogoUrl = [dict objectForKey:@"provider_logo"];
                strLogoUrl = [strLogoUrl stringByReplacingOccurrencesOfString:@"{size}" withString:ICON_SIZE];
                searchData.providerLogo = strLogoUrl;
                searchData.price = [[dict objectForKey:@"price_in_euros"] doubleValue];
                [arrResults addObject:searchData];
            }
        }
        
    }
    return arrResults;
}
@end
