//
//  VenueCellViewModel.h
//  UrbanVenues
//
//  Created by Rao, Amit on 7/12/15.
//  Copyright (c) 2015 Rao, Amit. All rights reserved.
//

@import Foundation;
@import UIKit;

@class VenueModel;

@interface VenueCellViewModel : NSObject

@property (nonatomic, assign) NSString *venueTitle;
@property (nonatomic, assign) NSInteger venueDistance;
@property (nonatomic, strong) UIImage *venueIconImage;

+ (instancetype)createVenueCellViewModel:(VenueModel *)venueModel;

@end
