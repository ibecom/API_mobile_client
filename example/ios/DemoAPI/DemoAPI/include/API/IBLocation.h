//
//  IBLocation.h
//  IBApi
//
//  Copyright © 2014-2016 iBecom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBPoint.h"

@protocol IBLocation <IBPoint>
@property float accuracy;
@property float azimuth;
@end
