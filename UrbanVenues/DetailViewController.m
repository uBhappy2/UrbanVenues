//
//  DetailViewController.m
//  UrbanVenues
//
//  Created by Rao, Amit on 7/10/15.
//  Copyright (c) 2015 Rao, Amit. All rights reserved.
//

#import "DetailViewController.h"
#import "VenueModel.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.venueModel.title;
    [self renderVenueDetails];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)renderVenueDetails
{
    UIImage *venueImage = [self.venueModel.venuePhotos getPrimaryPhotoOfVenue];

    if(venueImage) {
        self.venueImageView.image = venueImage;
    }

    self.venueTitle.text = self.venueModel.title;

    self.addressLabel.text = self.venueModel.address;
    [self.addressLabel sizeToFit];

    if(self.venueModel.phone) {
        self.phoneLabel.text = [NSString stringWithFormat:@"Phone : %@",self.venueModel.phone];
        [self.phoneLabel sizeToFit];
    }
    else {
        self.phoneLabel.hidden = YES;
    }

    if(self.venueModel.hours) {
        self.hoursLabel.text = [NSString stringWithFormat:@"Hours : %@", self.venueModel.hours];
        [self.hoursLabel sizeToFit];
    } else {
        self.hoursLabel.hidden = YES;
    }

}

@end
