//
//  FoursquareService.h
//  UrbanVenues
//
//  Created by Rao, Amit on 7/10/15.
//  Copyright (c) 2015 Rao, Amit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoursquareService : NSObject

+ (instancetype)sharedInstance;
- (NSDictionary *)searchByLocation:(CLLocation *)location;
- (NSDictionary *)searchByQueryString:(NSString *)queryString;

@end
