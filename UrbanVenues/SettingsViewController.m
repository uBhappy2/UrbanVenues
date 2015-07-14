//
//  SettingsViewController.m
//  UrbanVenues
//
//  Created by Rao, Amit on 7/13/15.
//  Copyright (c) 2015 Rao, Amit. All rights reserved.
//

@import CoreLocation;
@import Foundation;
#import "FoursquareService.h"
#import "SettingsViewController.h"

@interface SettingsViewController () <CLLocationManagerDelegate>

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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    if(sender == self.locationSwitch)
    {
        if(sender.isOn)
        {
            if(!self.locationManager)
            {
                [self _initLocationManager];
            }
            [userDefaults setValue:@(1) forKey:kLocationEnabledKey];
            [userDefaults synchronize];
        }
        else
        {
            [self.locationManager stopUpdatingLocation];
            self.locationManager = nil;
            [userDefaults removeObjectForKey:kLocationEnabledKey];
            [userDefaults synchronize];
        }
    }
}

- (BOOL)isGeoLocationEnabled
{
    return self.locationSwitch.isOn;
}

- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

   switch(status)
    {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [userDefaults setValue:@(1) forKey:kLocationEnabledKey];
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
            [userDefaults removeObjectForKey:kLocationEnabledKey];
    }

    [userDefaults synchronize];
}
@end
