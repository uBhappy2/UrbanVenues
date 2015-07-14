//
//  VenueCellViewModel.m
//  UrbanVenues
//
//  Created by Rao, Amit on 7/12/15.
//  Copyright (c) 2015 Rao, Amit. All rights reserved.
//

#import "PhotoDTO.h"
#import "VenueCellViewModel.h"
#import "VenueModel.h"

@implementation VenueCellViewModel

+ (VenueCellViewModel *)createVenueCellViewModel:(VenueModel *)venueModel
{
    VenueCellViewModel *newModel = [VenueCellViewModel new];
    newModel.venueTitle = venueModel.title;
    newModel.venueIconImage = [venueModel.bestPhoto getVenuePhotoIcon];
    newModel.venueDistance = venueModel.distance;

    return newModel;
}

@end
