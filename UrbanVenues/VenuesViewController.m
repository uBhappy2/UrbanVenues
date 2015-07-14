//
//  ViewController.m
//  UrbanVenues
//
//  Created by Rao, Amit on 7/10/15.
//  Copyright (c) 2015 Rao, Amit. All rights reserved.
//
#import "DetailViewController.h"
#import "DSActivityView.h"
#import "FoursquareService.h"
#import "SettingsViewController.h"
#import "VenuesViewController.h"
#import "VenueCellViewModel.h"
#import "VenueModel.h"

@interface VenuesViewController () <UISearchBarDelegate, CLLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UIButton *settingsButton;
@property (nonatomic, strong) NSMutableArray *venuesList;
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
            self.venuesList = [NSMutableArray arrayWithArray:[[FoursquareService sharedInstance] listOfVenuesByLocation:self.settingsController.locationManager.location]];
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
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setValue:@(1) forKey:kLocationEnabledKey];
            [userDefaults synchronize];

            self.venuesList = [NSMutableArray arrayWithArray:[[FoursquareService sharedInstance] listOfVenuesByLocation:self.locationManager.location]];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    cell.imageView.image = [UIImage imageNamed:@"Placeholder"];
    cell.textLabel.text = nil;
    cell.detailTextLabel.text = nil;

    VenueModel *currentVenueModel = [self.venuesList objectAtIndex:indexPath.row];
    VenueCellViewModel *venueCellModel = [VenueCellViewModel createVenueCellViewModel:currentVenueModel];

    cell.textLabel.text = venueCellModel.venueTitle;

    if(venueCellModel.venueDistance){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Distance %ld meters", venueCellModel.venueDistance];

    }
    else {
        cell.detailTextLabel.hidden = YES;
    }

    if(venueCellModel.venueIconImage) {
        cell.imageView.image = venueCellModel.venueIconImage;
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}

#pragma mark - Navigation

- (void)prepareViewController:(id)vc forSegue:(NSString *)segueIdentifer fromIndexPath:(NSIndexPath *)indexPath
{
    VenueModel *venueModel = [self.venuesList objectAtIndex:indexPath.row];

    if([segueIdentifer isEqualToString:@"ShowDetail"]) {
        DetailViewController *detailController = (DetailViewController *)vc;
        detailController.venueModel = venueModel;
    }

}

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

     NSIndexPath *indexPath = nil;

     if([segue.identifier isEqualToString:@"ShowDetail"]) {
         DetailViewController *detailController = segue.destinationViewController;
         if([sender isKindOfClass:[UITableViewCell class]]) {
              indexPath = [self.tableView indexPathForCell:sender];
         }

         [self prepareViewController:detailController forSegue:segue.identifier fromIndexPath:indexPath];

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
    NSLog(@"Search Bar Text - %@", searchBar.text);
    NSString* queryString = searchBar.text;
    [self.venuesList removeAllObjects];

    DSActivityView *activityView = [DSBezelActivityView newActivityViewForView: self.view withLabel:		@"Searching..." width: 120];

    [activityView setOpaque:YES];

    dispatch_queue_t search_queue = dispatch_queue_create("search queue", NULL);

    dispatch_async(search_queue, ^{

        if([[FoursquareService sharedInstance] isGeolocationEnabled]) {
            self.venuesList = [NSMutableArray arrayWithArray:[[FoursquareService sharedInstance] listOfVenuesByLocation:self.locationManager.location andQueryString:queryString]];
        }
        else {
            self.venuesList = [NSMutableArray arrayWithArray:[[FoursquareService sharedInstance] listOfVenuesByQueryString:queryString]];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [DSBezelActivityView removeViewAnimated:YES];

        });
    });
}

// Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", [locations lastObject]);
}


@end
