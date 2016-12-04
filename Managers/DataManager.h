//
//  DataManager.h
//  TestGoEuro
//
//  Created by Macbook on 04/12/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject
/**
 @return Singleton instance of DataManager
 */
+ (instancetype)sharedManager;

/**
 @abstract Parse response
 @param Response as NSData
 @return Array of SearchData objects
 */
- (NSArray *)parseResponse:(NSData*)responseData;
@end
