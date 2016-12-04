//
//  SearchData.h
//  TestGoEuro
//
//  Created by Macbook on 04/12/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchData : NSObject
/**
 @abstract Departure Time as string
 */
@property(nonatomic,strong) NSString* departureTime;

/**
 @abstract Arrival Time as string
 */
@property(nonatomic,strong) NSString* arrivalTime;

/**
 @abstract Number Of Stops as integer
 */
@property(nonatomic,assign) int numberOfStops;

/**
 @abstract Provider Logo URL as string
 */
@property(nonatomic,strong) NSString* providerLogo;

/**
 @abstract Price as double
 */
@property(nonatomic,assign) double price;

/**
 @abstract Duration as string
 */
@property(nonatomic,strong) NSString* duration;
@end
