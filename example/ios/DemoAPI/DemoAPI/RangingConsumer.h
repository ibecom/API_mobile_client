//
//  RangingConsumer.h
//  DemoAPI
//
//  Copyright © 2014-2016 iBecom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBApi.h"

@interface RangingConsumer : NSObject <IBRangingConsumer>
@property (strong) NSString* consumerId;
@property (strong) NSString* name;
@property (strong) NSArray* beacons;
@property (strong) NSArray* regions;

@end
