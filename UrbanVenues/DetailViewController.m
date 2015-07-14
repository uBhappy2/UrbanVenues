//
//  DetailViewController.m
//  UrbanVenues
//
//  Created by Rao, Amit on 7/10/15.
//  Copyright (c) 2015 Rao, Amit. All rights reserved.
//

#import "DetailViewController.h"
#import "PhotoDTO.h"
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

    [self.venueModel.bestPhoto getVenuePhotoDataAndProcessData:^(NSData *imageData){
        self.venueImageView.image = [UIImage imageWithData:imageData];
    }];


    self.venueTitle.text = self.venueModel.title;

    self.addressLabel.text = self.venueModel.address;

    if(self.venueModel.city && self.venueModel.state && self.venueModel.zip) {
        self.cityStateZipLabel.text = [NSString stringWithFormat:@"%@, %@ %@", self.venueModel.city, self.venueModel.state, self.venueModel.zip];
    }
    else {
        self.cityStateZipLabel.hidden = YES;
    }

    if(self.venueModel.phone) {
        self.phoneLabel.text = [NSString stringWithFormat:@"Phone : %@",self.venueModel.phone];
        [self.phoneLabel sizeToFit];
    }
    else {
        self.phoneLabel.hidden = YES;
    }

    if(self.venueModel.status) {
        self.hoursLabel.text = self.venueModel.status;
    } else {
        self.hoursLabel.hidden = YES;
    }

    if(self.venueModel.url) {
        self.urlLabel.text = self.venueModel.url;
    }
    else {
        self.urlLabel.hidden = YES;
    }

    if(self.venueModel.rating > 0 && self.venueModel.ratingSignals > 0) {
        self.ratingsLabel.text = [NSString stringWithFormat:@"%.2f based on %ld ratings", self.venueModel.rating, self.venueModel.ratingSignals];
    }
    else {
        self.ratingsLabel.hidden = YES;
    }
    
}

@end
