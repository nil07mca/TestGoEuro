//
//  ConnectionManager.m
//  TestGoEuro
//
//  Created by Macbook on 04/12/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import "ConnectionManager.h"
#import "Constants.h"
#import "DataManager.h"

@interface ConnectionManager ()<NSURLSessionDelegate>
@property(nonatomic,copy) ConnectionManagerSuccessHandler successHandler;
@property(nonatomic,copy) ConnectionManagerFailureHandler failureHandler;
@end

@implementation ConnectionManager

+ (instancetype)sharedManager
{
    static ConnectionManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ConnectionManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (void)loadFlightsWithSuccessHandler:(ConnectionManagerSuccessHandler)success
                    andFailureHandler:(ConnectionManagerFailureHandler)failure
{
    self.successHandler = success;
    self.failureHandler = failure;
    [self fetchDataformServer:FLIGHTS_URL];
}


- (void)loadTrainsWithSuccessHandler:(ConnectionManagerSuccessHandler)success
                   andFailureHandler:(ConnectionManagerFailureHandler)failure
{
    self.successHandler = success;
    self.failureHandler = failure;
    [self fetchDataformServer:TRAINS_URL];
}


- (void)loadBusesWithSuccessHandler:(ConnectionManagerSuccessHandler)success
                  andFailureHandler:(ConnectionManagerFailureHandler)failure
{
    self.successHandler = success;
    self.failureHandler = failure;
    [self fetchDataformServer:BUSES_URL];
}

- (void)fetchDataformServer:(NSString *)strUrl
{
    NSURL *url = [[NSURL alloc]initWithString:strUrl];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error == nil)
        {
             self.successHandler([[DataManager sharedManager] parseResponse:data]);
        }
        else
        {
            [self handleError:error];
        }
        
    }];
    [dataTask resume];
}

#pragma mark - Handle Error
- (void) handleError:(NSError *)error {
    self.failureHandler(error);
}

@end
