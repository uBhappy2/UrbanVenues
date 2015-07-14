//
//  VenueModel.h
//  UrbanVenues
//
//  Created by Rao, Amit on 7/10/15.
//  Copyright (c) 2015 Rao, Amit. All rights reserved.
//

@import Foundation;
@import UIKit;
#import "PhotosListDTO.h" 

@interface VenueModel : NSObject

@property (nonatomic, strong) PhotosListDTO *venuePhotos;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zip;
@property (nonatomic, assign) NSInteger distance;
@property (nonatomic, strong) NSArray *listOfTips;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, assign) NSInteger numberLikes;
@property (nonatomic, assign) NSInteger rank;
@property (nonatomic, strong) NSString *primaryCategory;
@property (nonatomic, strong) NSString *hours;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) double rating;
@property (nonatomic, assign) NSInteger ratingSignals;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) PhotoDTO *bestPhoto;
@property (nonatomic, strong) NSString *venueDescription;

- (void)setVenuePhotos;

@end
