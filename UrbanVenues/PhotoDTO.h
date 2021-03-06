//
//  PhotoDTO.h
//  UrbanVenues
//
//  Created by Rao, Amit on 7/13/15.
//  Copyright (c) 2015 Rao, Amit. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface PhotoDTO : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *prefix;
@property (nonatomic, strong) NSString *suffix;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;

- (UIImage *)getVenuePhoto;
- (UIImage *)getVenuePhotoIcon;
- (void)getVenuePhotoDataAndProcessData:(void (^)(NSData *imageData))processImage;
- (void)getVenuePhotoIconDataAndProcessData:(void (^)(NSData *imageData))processImage;

@end
