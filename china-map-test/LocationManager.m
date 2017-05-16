//
//  LocationManager.m
//  panobikeplus-trip-planer
//
//  Created by Shih Yun Shen on 24/03/2017.
//  Copyright © 2017 Topeak. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager () <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *clManager;
@property (assign, nonatomic) CLLocationCoordinate2D currentLocation;
@end
@implementation LocationManager

+ (instancetype)manager {
    static LocationManager * m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [LocationManager new];
        m.clManager = [[CLLocationManager alloc] init];
        m.clManager.delegate = m;
        m.currentLocation = kCLLocationCoordinate2DInvalid;
    });
    return m;
}

- (void)authorizeIfNecessary {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined) {
        [self.clManager requestWhenInUseAuthorization];
    } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.clManager startUpdatingLocation];
    }
}

- (CLAuthorizationStatus)authorizationStatus {
    return [CLLocationManager authorizationStatus];
}


- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.clManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *lastUpdatedLocation = locations.lastObject;
    NSDate * eventDate = lastUpdatedLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (howRecent < 15.0) {
        self.currentLocation = lastUpdatedLocation.coordinate;
    }
}
@end
