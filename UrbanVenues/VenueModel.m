//
//  VenueModel.m
//  UrbanVenues
//
//  Created by Rao, Amit on 7/10/15.
//  Copyright (c) 2015 Rao, Amit. All rights reserved.
//

#import "VenueModel.h"
#import "FoursquareService.h"

@implementation VenueModel

- (void)setVenuePhotos
{
    self.venuePhotos = [[FoursquareService sharedInstance] listOfPhotosForVenue:self.id];
}

@end
