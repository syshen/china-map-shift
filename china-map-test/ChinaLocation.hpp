//
//  ChinaLocation.hpp
//  china-map-test
//
//  Created by Shih Yun Shen on 16/05/2017.
//  Copyright © 2017 Panobike. All rights reserved.
//

#ifndef ChinaLocation_hpp
#define ChinaLocation_hpp

#include <stdio.h>

typedef struct {
    double lng;
    double lat;
} Location;

inline Location
LocationMake(double lng, double lat) {
    Location loc; loc.lng = lng, loc.lat = lat; return loc;
}

extern Location transformFromWGSToGCJ(Location wgLoc);
extern Location bd_encrypt(Location gcLoc);
#endif /* ChinaLocation_hpp */
