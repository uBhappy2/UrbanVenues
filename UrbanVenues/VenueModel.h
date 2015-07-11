//
//  VenueModel.h
//  UrbanVenues
//
//  Created by Rao, Amit on 7/10/15.
//  Copyright (c) 2015 Rao, Amit. All rights reserved.
//

@import Foundation;
@import UIKit;
#import "PhotosDTO.h" 

@interface VenueModel : NSObject

@property (nonatomic, strong) UIImage *venueIconImage;
@property (nonatomic, strong) PhotosDTO *venuePhotos;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSArray *listOfTips;
@property (nonatomic, strong) NSArray *hours;
@property (nonatomic, assign) NSInteger likesCount;




@end
