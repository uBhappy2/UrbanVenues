//
//  DetailViewController.h
//  UrbanVenues
//
//  Created by Rao, Amit on 7/10/15.
//  Copyright (c) 2015 Rao, Amit. All rights reserved.
//

@import UIKit;

@class VenueModel;

@interface DetailViewController : UIViewController

@property (nonatomic, strong) VenueModel *venueModel;

@property (nonatomic, retain) IBOutlet UIImageView *venueImageView;
@property (nonatomic, weak) IBOutlet UILabel *ratingsLabel;
@property (nonatomic, weak) IBOutlet UILabel *venueTitle;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UILabel *phoneLabel;
@property (nonatomic, weak) IBOutlet UILabel *hoursLabel;

- (void)renderVenueDetails;

@end
