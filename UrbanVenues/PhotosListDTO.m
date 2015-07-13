//
//  PhotosDTO.m
//  UrbanVenues
//
//  Created by Rao, Amit on 7/10/15.
//  Copyright (c) 2015 Rao, Amit. All rights reserved.
//

#import "PhotosListDTO.h"

@implementation PhotosListDTO

- (PhotoDTO *)firstPhotoOfVenue
{
    if([self count] > 0)
    {
        return self.photos[0];
    }

    return nil;
}

@end
