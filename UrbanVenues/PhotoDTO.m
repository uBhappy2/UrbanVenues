//
//  PhotoDTO.m
//  UrbanVenues
//
//  Created by Rao, Amit on 7/13/15.
//  Copyright (c) 2015 Rao, Amit. All rights reserved.
//

#import "PhotoDTO.h"
#import "FoursquareService.h"

@implementation PhotoDTO

- (FoursquareService *)_foursquareService
{
    return [FoursquareService sharedInstance];
}


- (UIImage *)getVenuePhoto
{
    NSString *imageUrl = [NSString stringWithFormat:@"%@%ldx%ld%@", self.prefix, self.width, self.height, self.suffix];

    return [[self _foursquareService] getImage:imageUrl];
}

- (UIImage *)getVenuePhotoIcon
{
    NSString *imageUrl = [NSString stringWithFormat:@"%@100x100%@", self.prefix, self.suffix];

    return [[self _foursquareService] getImage:imageUrl];
}



@end
