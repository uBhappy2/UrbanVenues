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
- (NSArray *)listOfVenuesByLocation:(CLLocation *)location;
- (NSArray *)listOfVenuesByQueryString:(NSString *)queryString;

@end
