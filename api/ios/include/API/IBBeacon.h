//
//  IBBeacon.h
//  IBApi
//
//  Copyright © 2014-2016 iBecom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBBeaconIdentity.h"

@protocol IBBeacon <NSObject>
@property (readonly) id<IBBeaconIdentity> identity;

@property (readonly) float distance;
@property (readonly) float rssi;

@property BOOL available;
@end
