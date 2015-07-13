//
//  SettingsViewController.h
//  UrbanVenues
//
//  Created by Rao, Amit on 7/13/15.
//  Copyright (c) 2015 Rao, Amit. All rights reserved.
//

@import UIKit;

@interface SettingsViewController : UIViewController

@property (nonatomic, weak) IBOutlet UISwitch *locationSwitch;
@property (nonatomic, strong) CLLocationManager *locationManager;

- (BOOL)isGeoLocationEnabled;

@end
