//
//  ViewController.m
//  UrbanVenues
//
//  Created by Rao, Amit on 7/10/15.
//  Copyright (c) 2015 Rao, Amit. All rights reserved.
//
#import "DetailViewController.h"
#import "FoursquareService.h"
#import "VenuesViewController.h"
#import "SettingsViewController.h"

@interface VenuesViewController () <UISearchBarDelegate, CLLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UIButton *settingsButton;
@property (nonatomic, strong) NSArray *venuesList;
@property (nonatomic, strong) SettingsViewController *settingsController;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation VenuesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Urban Venues";

    if(self.settingsController)
    {
        if([self.settingsController isGeoLocationEnabled]) {
            self.venuesList = [[FoursquareService sharedInstance] listOfVenuesByLocation:self.settingsController.locationManager.location];
        }
    }
    else
    {
        self.locationManager = [[CLLocationManager alloc] init];
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }

        [self.locationManager startUpdatingLocation];

        if(self.locationManager.location) {
            self.venuesList = [[FoursquareService sharedInstance] listOfVenuesByLocation:self.locationManager.location];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];


    [self.tableView reloadData];
}

#pragma mark - UITableViewDatasource delegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.venuesList count];
}

#pragma mark - UITableViewDelegate delegate methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Venue Cell";

    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }

    

    return cell;
}


 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if([segue.identifier isEqualToString:@"ShowDetail"]) {


     }
     else if([segue.identifier isEqualToString:@"ShowSettings"]){
         self.settingsController = segue.destinationViewController;
     }

 }


- (IBAction)settingsButtonTapped:(id)sender
{
    [self performSegueWithIdentifier:@"ShowSettings" sender:sender];

}

#pragma mark - UISearchBarDelegate delegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // Do nothing
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{

    [searchBar resignFirstResponder];
}

// Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", [locations lastObject]);
}


@end
