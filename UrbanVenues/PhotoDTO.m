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
    NSString *imageUrl = [NSString stringWithFormat:@"%@48x32%@", self.prefix, self.suffix];

    return [[self _foursquareService] getImage:imageUrl];
}


- (void)getVenuePhotoDataAndProcessData:(void (^)(NSData *imageData))processImage
{
     NSString *imageUrl = [NSString stringWithFormat:@"%@%ldx%ld%@", self.prefix, self.width, self.height, self.suffix];

    [[self _foursquareService] queryUrlString:imageUrl andProcessImageData:processImage];
}

- (void)getVenuePhotoIconDataAndProcessData:(void (^)(NSData *imageData))processImage
{
    NSString *imageUrl = [NSString stringWithFormat:@"%@48x32%@", self.prefix, self.suffix];

    [[self _foursquareService] queryUrlString:imageUrl andProcessImageData:processImage];
}


@end
