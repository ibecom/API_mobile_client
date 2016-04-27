//
//  IBTimedLocation.h
//  IBApi
//
//  Copyright © 2014-2016 iBecom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBLocation.h"

@protocol IBTimedLocation <IBLocation>
@property long long timestamp;
@property float azimuth;
@end
