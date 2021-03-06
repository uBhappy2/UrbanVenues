//
//  FoursquareService.m
//  UrbanVenues
//
//  Created by Rao, Amit on 7/10/15.
//  Copyright (c) 2015 Rao, Amit. All rights reserved.
//

@import  CoreLocation;
#import "FoursquareService.h"
#import "PhotoDTO.h"
#import "PhotosListDTO.h"
#import "VenueModel.h"

#define DEBUG 1

NSString * const kLocationEnabledKey = @"geolocationEnabled";

@interface FoursquareService () <CLLocationManagerDelegate>

@end

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

- (NSDictionary *)_searchByLocation:(CLLocation *)location
{
    CLLocationDegrees latitude = location.coordinate.latitude;
    CLLocationDegrees longitide = location.coordinate.longitude;

    NSString *urlString = [NSString stringWithFormat:@"%@search?ll=%f,%f&client_id=%@&client_secret=%@&v=%@",baseUrl, latitude, longitide, CLIENT_ID, CLIENT_SECRET, VERSION];

#if DEBUG
    NSLog(@"Search By Location %@", urlString);
#endif

    return [self _sendHttpRequest:urlString];
}

- (NSDictionary *)_searchByQueryString:(NSString *)queryString
{
     NSString *urlString = [NSString stringWithFormat:@"%@search?intent=global&query=%@&client_id=%@&client_secret=%@&v=%@",baseUrl, queryString, CLIENT_ID, CLIENT_SECRET, VERSION];

#if DEBUG
     NSLog(@"Search By Query String %@", urlString);
#endif

    return [self _sendHttpRequest:urlString];
}

- (NSDictionary *)_searchByLocation:(CLLocation *)location andQueryString:(NSString *)queryString
{
    CLLocationDegrees latitude = location.coordinate.latitude;
    CLLocationDegrees longitide = location.coordinate.longitude;

    NSString *urlString = [NSString stringWithFormat:@"%@search?ll=%f,%f&query=%@&client_id=%@&client_secret=%@&v=%@",baseUrl, latitude, longitide, queryString, CLIENT_ID, CLIENT_SECRET, VERSION];

#if DEBUG
    NSLog(@"Search By Query String %@", urlString);
#endif

    return [self _sendHttpRequest:urlString];
}


- (NSDictionary *)_sendHttpRequest:(NSString *)urlString
{
    NSString* encodedUrlString = [urlString stringByAddingPercentEscapesUsingEncoding:
                                  NSUTF8StringEncoding];

    NSURL *url = [NSURL URLWithString:encodedUrlString];

    NSData *jsonData = [NSData dataWithContentsOfURL:url];

    NSError *error = nil;
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);

    return results;

}

- (BOOL) _isHTTPResponse200OK:(NSDictionary *)dict
{
    NSInteger httpResponseCode = [dict[@"meta"][@"code"] integerValue];
    return httpResponseCode == 200;
}


- (NSArray *)listOfVenuesByLocation:(CLLocation *)location
{
    NSDictionary *venuesDictionary = [self _searchByLocation:location];

    if(venuesDictionary) {
        return [self _parseVenuesJSONDictionaryAndReturnVenueModelsList:venuesDictionary];
    }

    return nil;
}

- (NSArray *)listOfVenuesByQueryString:(NSString *)queryString
{
    NSDictionary *venuesDictionary = [self _searchByQueryString:queryString];

    if(venuesDictionary) {
        return [self _parseVenuesJSONDictionaryAndReturnVenueModelsList:venuesDictionary];
    }

    return nil;
}

- (NSArray *)listOfVenuesByLocation:(CLLocation *)location andQueryString:(NSString *)queryString
{
    NSDictionary *venuesDictionary = [self _searchByLocation:location andQueryString:queryString];

    if(venuesDictionary) {
        return [self _parseVenuesJSONDictionaryAndReturnVenueModelsList:venuesDictionary];
    }

    return nil;
}

- (NSDictionary *)photosJSONDataForVenue:(NSString *)venueId
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@/photos?client_id=%@&client_secret=%@&v=%@",baseUrl, venueId, CLIENT_ID, CLIENT_SECRET, VERSION];

    return [self _sendHttpRequest:urlString];
}

- (PhotosListDTO *)listOfPhotosForVenue:(NSString *)venueId
{
    NSDictionary *photosDict = [self photosJSONDataForVenue:venueId];
    return [self _parsePhotosJSONDictionaryAndReturnsVenuePhotos:photosDict];
}


- (NSDictionary *)venueJSONDataForVenue:(NSString *)venueId
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@?client_id=%@&client_secret=%@&v=%@",baseUrl, venueId, CLIENT_ID, CLIENT_SECRET, VERSION];

    return [self _sendHttpRequest:urlString];
}




- (VenueModel *)createVenueModel:(NSString *)venueId
{
    NSDictionary *venueDictionary = [self venueJSONDataForVenue:venueId];

    return [self _parseVenueJSONDictionaryAndReturnVenueModel:venueDictionary];
}



- (VenueModel *)_parseVenueJSONDictionaryAndReturnVenueModel:(NSDictionary *)venueDictionary
{
    VenueModel *venueModel = nil;

    if([self _isHTTPResponse200OK:venueDictionary]) {
        NSDictionary *venueDict = venueDictionary[@"response"][@"venue"];
        venueModel = [VenueModel new];
        venueModel.id = venueDict[@"id"];
        venueModel.title = venueDict[@"name"];
        venueModel.phone = venueDict[@"contact"][@"formattedPhone"];
        venueModel.address = venueDict[@"location"][@"address"];
        venueModel.city = venueDict[@"location"][@"city"];
        venueModel.state = venueDict[@"location"][@"state"];
        venueModel.zip = venueDict[@"location"][@"postalCode"];
        venueModel.distance = [venueDict[@"location"][@"distance"] integerValue];
        venueModel.latitude = [venueDict[@"location"][@"latitude"] doubleValue];
        venueModel.longitude = [venueDict[@"location"][@"longitude"] doubleValue];
        venueModel.url = venueDict[@"url"];
        venueModel.numberLikes = [venueDict[@"likes"][@"count"] integerValue];
        venueModel.rating = [venueDict[@"rating"] integerValue];
        venueModel.ratingSignals = [venueDict[@"ratingSignals"] integerValue];
        venueModel.status = venueDict[@"hours"][@"status"];

        PhotoDTO *bestPhotoDTO = [PhotoDTO new];
        bestPhotoDTO.id = venueDict[@"bestPhoto"][@"id"];
        bestPhotoDTO.prefix = venueDict[@"bestPhoto"][@"prefix"];
        bestPhotoDTO.suffix = venueDict[@"bestPhoto"][@"suffix"];
        bestPhotoDTO.width = [venueDict[@"bestPhoto"][@"width"] integerValue];
        bestPhotoDTO.height = [venueDict[@"bestPhoto"][@"height"] integerValue];
        venueModel.bestPhoto = bestPhotoDTO;

        venueModel.venueDescription = venueDict[@"description"];

    }
    else {
        //handle HTTP error codes (TBD)

    }

    return venueModel;
}



- (NSArray *)_parseVenuesJSONDictionaryAndReturnVenueModelsList:(NSDictionary *)venuesDictionary
{
    if([self _isHTTPResponse200OK:venuesDictionary])
    {
        NSMutableArray *venuesModelList = [NSMutableArray array];
        NSArray *venuesList = venuesDictionary[@"response"][@"venues"];
        for(NSDictionary *venueDict in venuesList)
        {
            VenueModel *venueModel = [self createVenueModel:venueDict[@"id"]];

            venueModel.distance = [venueDict[@"location"][@"distance"] integerValue];

            [venueModel setVenuePhotos];

            if(venueModel){
                [venuesModelList addObject:venueModel];
            }
        }

        return venuesModelList;
    }
    else {
        //handle HTTP error codes (TBD)
        
    }

    return nil;
}

- (PhotosListDTO *)_parsePhotosJSONDictionaryAndReturnsVenuePhotos:(NSDictionary *)photosDict
{
    if([self _isHTTPResponse200OK:photosDict])
    {
        PhotosListDTO *photosListDTO = [PhotosListDTO new];
        photosListDTO.count = [photosDict[@"response"][@"photos"][@"count"] integerValue];

        photosListDTO.photos = [NSMutableArray array];
        NSArray *photosList = photosDict[@"response"][@"photos"][@"items"];
        for(NSDictionary *photoDict in photosList)
        {
            PhotoDTO *photo = [PhotoDTO new];
            photo.id = photoDict[@"id"];
            photo.prefix = photoDict[@"prefix"];
            photo.suffix = photoDict[@"suffix"];
            photo.width = [photoDict[@"width"] integerValue];
            photo.height = [photoDict[@"height"] integerValue];

            [photosListDTO.photos addObject:photo];
        }
        
        return photosListDTO;
    }
    else {
        //handle HTTP error codes (TBD)

    }

    return nil;

}

- (UIImage *)getImage:(NSString *)imageUrl
{
    NSString* encodedUrlString = [imageUrl stringByAddingPercentEscapesUsingEncoding:
                                  NSUTF8StringEncoding];

    NSURL *url = [NSURL URLWithString:encodedUrlString];

    NSData *imageData = [NSData dataWithContentsOfURL:url];

    UIImage *image = [UIImage imageWithData:imageData];

    return image;
}

- (void)queryUrlString:(NSString *)imageUrl andProcessImageData:(void (^)(NSData *imageData))processImage
{
    NSString* encodedUrlString = [imageUrl stringByAddingPercentEscapesUsingEncoding:
                                  NSUTF8StringEncoding];

    NSURL *url = [NSURL URLWithString:encodedUrlString];

    dispatch_queue_t download_queue = dispatch_queue_create("download queue", NULL);
    dispatch_async(download_queue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            processImage(imageData);
        });
    });
    
}

- (BOOL)isGeolocationEnabled
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:kLocationEnabledKey];
}

// Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", [locations lastObject]);
}

@end
