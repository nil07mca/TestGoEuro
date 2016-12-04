//
//  ConnectionManager.h
//  TestGoEuro
//
//  Created by Macbook on 04/12/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectionManager : NSObject

typedef void (^ConnectionManagerSuccessHandler)(NSArray* results);
typedef void (^ConnectionManagerFailureHandler)(NSError* error);
/**
 @return Singleton instance of ConnectionManager
 */
+ (instancetype)sharedManager;

/**
 @abstract Initiate service call to load list of Flights
 */
- (void)loadFlightsWithSuccessHandler:(ConnectionManagerSuccessHandler)success
                     andFailureHandler:(ConnectionManagerFailureHandler)failure;

/**
 @abstract Initiate service call to load list of Trains
 */
- (void)loadTrainsWithSuccessHandler:(ConnectionManagerSuccessHandler)success
                    andFailureHandler:(ConnectionManagerFailureHandler)failure;

/**
 @abstract Initiate service call to load list of Buses
 */
- (void)loadBusesWithSuccessHandler:(ConnectionManagerSuccessHandler)success
                    andFailureHandler:(ConnectionManagerFailureHandler)failure;
@end

