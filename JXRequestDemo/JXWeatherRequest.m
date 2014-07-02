//
//  JXWeatherRequest.m
//  JXRequestDemo
//
//  Created by andy on 14-7-2.
//  Copyright (c) 2014年 andy. All rights reserved.
//

#import "JXWeatherRequest.h"

#define WEATHER_URL @"http://maps.google.com/maps/api/geocode/json"

@implementation JXWeatherRequest

- (id)init {
    
    if (self = [super init]) {
        self.url = WEATHER_URL;
    }
    
    return self;
}

- (void)start {
    [self.params setObject:@"金融街" forKey:@"address"];
    [self.params setObject:@"false" forKey:@"sensor"];

    [self startGetRequest:self.url params:self.params];
}

@end
