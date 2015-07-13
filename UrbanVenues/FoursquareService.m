//
//  FoursquareService.m
//  UrbanVenues
//
//  Created by Rao, Amit on 7/10/15.
//  Copyright (c) 2015 Rao, Amit. All rights reserved.
//

@import  CoreLocation;
#import "FoursquareService.h"


@implementation FoursquareService

static const NSString *baseUrl = @"https://api.foursquare.com/v2/venues/";
static const NSString *CLIENT_ID = @"RWMX5RT24ALLOT2DWRW1FZ4OTEFP5ZJ0L4YQWORGL2PNDISE";
static const NSString *CLIENT_SECRET = @"QPV1PKBPRGEWXXPLWELZSQCXBL4ZJ0UTYVI5KAK23MXQPTEP";
static const NSString *VERSION = @"20150712";

+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });

    return _sharedInstance;
}

- (NSDictionary *)searchByLocation:(CLLocation *)location
{
    CLLocationDegrees latitude = location.coordinate.latitude;
    CLLocationDegrees longitide = location.coordinate.longitude;

    NSString *urlString = [NSString stringWithFormat:@"%@search?ll=%f,%f&client_id=%@&client_secret=%@&v=%@",baseUrl, latitude, longitide, CLIENT_ID, CLIENT_SECRET, VERSION];

    NSString* encodedUrlString = [urlString stringByAddingPercentEscapesUsingEncoding:
                                  NSUTF8StringEncoding];

    NSURL *url = [NSURL URLWithString:encodedUrlString];

    NSData *jsonData = [NSData dataWithContentsOfURL:url];

    NSError *error = nil;
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);

    return results;
}

- (NSDictionary *)searchByQueryString:(NSString *)queryString
{
     NSString *urlString = [NSString stringWithFormat:@"%@search?intent=global&query=%@&client_id=%@&client_secret=%@&v=%@",baseUrl, queryString, CLIENT_ID, CLIENT_SECRET, VERSION];

    NSString* encodedUrlString = [urlString stringByAddingPercentEscapesUsingEncoding:
                                  NSUTF8StringEncoding];

    NSURL *url = [NSURL URLWithString:encodedUrlString];

    NSData *jsonData = [NSData dataWithContentsOfURL:url];

    NSError *error = nil;
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);

    return results;
}

- (NSArray *)listOfVenuesByLocation:(CLLocation *)location
{
    NSDictionary *venuesDictionary = [self searchByLocation:location];

    
    return nil;
}

@end
