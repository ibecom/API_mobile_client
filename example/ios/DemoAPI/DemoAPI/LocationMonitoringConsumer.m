//
//  LocationMonitoringConsumer.m
//  DemoAPI
//
//  Created by Eugene Kuropatenko on 24.11.15.
//  Copyright © 2015 iBecom. All rights reserved.
//

#import "LocationMonitoringConsumer.h"

@implementation LocationMonitoringConsumer

-(instancetype)init {
    if (self) {
        self.creation = [NSDate date];
    }
    return self;
}

- (void)locationManager:(id<IBLocationManager>)manager didFailWithError:(IBError*)error{
    NSLog(@"%@",error);
}

- (void)locationManager:(id<IBLocationManager>)manager didChangeLocation:(id<IBLocation>)location{
//    NSLog(@"locationManager didChangeLocation %@",  location);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didChangeLocation" object:location];
}

@end
