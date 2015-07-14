//
//  FoursquareService.h
//  UrbanVenues
//
//  Created by Rao, Amit on 7/10/15.
//  Copyright (c) 2015 Rao, Amit. All rights reserved.
//

@import Foundation;
@import UIKit;
@import CoreLocation;

@class PhotosListDTO;
@class VenueModel;

extern NSString * const kLocationEnabledKey;


@interface FoursquareService : NSObject

+ (instancetype)sharedInstance;
- (NSArray *)listOfVenuesByLocation:(CLLocation *)location;
- (NSArray *)listOfVenuesByQueryString:(NSString *)queryString;
- (NSArray *)listOfVenuesByLocation:(CLLocation *)location andQueryString:(NSString *)queryString;
- (PhotosListDTO *)listOfPhotosForVenue:(NSString *)venueId;
- (VenueModel *)createVenueModel:(NSString *)venueId;

- (UIImage *)getImage:(NSString *)imageUrl;
- (void)queryUrlString:(NSString *)imageUrl andProcessImageData:(void (^)(NSData *imageData))processImage;
- (BOOL)isGeolocationEnabled;

@end
