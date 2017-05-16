//
//  LocationManager.h
//  panobikeplus-trip-planer
//
//  Created by Shih Yun Shen on 24/03/2017.
//  Copyright © 2017 Topeak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject

@property (readonly) CLLocationCoordinate2D currentLocation;

+ (instancetype) manager;
- (void)authorizeIfNecessary;
- (CLAuthorizationStatus)authorizationStatus;

@end
