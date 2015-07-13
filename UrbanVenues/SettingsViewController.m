//
//  SettingsViewController.m
//  UrbanVenues
//
//  Created by Rao, Amit on 7/13/15.
//  Copyright (c) 2015 Rao, Amit. All rights reserved.
//

@import CoreLocation;
#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        if(self.locationSwitch.isOn)
        {
            [self _initLocationManager];
        }
    }
    return self;
}

- (void)_initLocationManager
{
    self.locationManager = [[CLLocationManager alloc] init];
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.locationManager requestWhenInUseAuthorization];
    }

    [self.locationManager startUpdatingLocation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)switchAction:(UISwitch *)sender
{
    if(sender == self.locationSwitch)
    {
        if(sender.isOn)
        {
            if(!self.locationManager)
            {
                [self _initLocationManager];
            }
        }
        else
        {
            [self.locationManager stopUpdatingLocation];
            self.locationManager = nil;
        }
    }
}

- (BOOL)isGeoLocationEnabled
{
    return self.locationSwitch.isOn;
}

@end
