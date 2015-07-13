//
//  PhotosDTO.m
//  UrbanVenues
//
//  Created by Rao, Amit on 7/10/15.
//  Copyright (c) 2015 Rao, Amit. All rights reserved.
//

#import "PhotosListDTO.h"
#import "PhotoDTO.h"

@implementation PhotosListDTO

- (PhotoDTO *)firstPhotoOfVenue
{
    if([self count] > 0)
    {
        return self.photos[0];
    }

    return nil;
}

- (UIImage *)getPrimaryPhotoOfVenue
{
    PhotoDTO *primaryPhoto = [self firstPhotoOfVenue];
    return [primaryPhoto getVenuePhoto];
}

- (UIImage *)getPrimaryPhotoIconOfVenue
{
    PhotoDTO *primaryPhoto = [self firstPhotoOfVenue];
    return [primaryPhoto getVenuePhotoIcon];
}


@end
