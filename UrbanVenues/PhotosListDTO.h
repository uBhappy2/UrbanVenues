//
//  PhotosDTO.h
//  UrbanVenues
//
//  Created by Rao, Amit on 7/10/15.
//  Copyright (c) 2015 Rao, Amit. All rights reserved.
//

@import Foundation;
@class PhotoDTO;

@interface PhotosListDTO : NSObject

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSMutableArray *photos;

- (PhotoDTO *)firstPhotoOfVenue;

@end
