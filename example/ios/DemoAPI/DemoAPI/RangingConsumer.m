//
//  RangingConsumer.m
//  DemoAPI
//
//  Copyright © 2014-2016 iBecom. All rights reserved.
//

#import "RangingConsumer.h"

@implementation RangingConsumer


- (void) rangingManager:(id<IBRangingManager>)manager didFailWithError:(IBError*)error{
    NSLog(@"rangingManager didFailWithError %@",error);
}

- (void) rangingManager:(id<IBRangingManager>)manager didUpdateBeacons:(NSArray*)beacons forConsumer:(id<IBRangingConsumer>)consumer{
    NSLog(@"rangingManager didUpdateBeacons %@",beacons);
}

- (void) rangingManager:(id<IBRangingManager>)manager didUpdateRegions:(NSArray*)regions forConsumer:(id<IBRangingConsumer>)consumer{
    NSLog(@"rangingManager didUpdateRegions %@",regions);
}

@end
