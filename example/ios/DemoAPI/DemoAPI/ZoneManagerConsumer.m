//
//  ZoneManagerConsumer.m
//  DemoAPI
//
//  Copyright © 2014-2016 iBecom. All rights reserved.
//

#import "ZoneManagerConsumer.h"
#import <UIKit/UIKit.h>


@implementation ZoneManagerConsumer

- (void) zoneManager:(id<IBZoneManager>)manager didChangedCurrentZone:(id<IBZone>)zone{
//    NSLog(@"zoneManager didChangedCurrentZone %@",zone);
//    UILocalNotification *ln = [[UILocalNotification alloc] init];
//    ln.alertBody = [NSString stringWithFormat:@"didChangedCurrentZone - %@", zone];
//    ln.fireDate = [NSDate date];
//    [[UIApplication sharedApplication] scheduleLocalNotification:ln];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didChangedCurrentZone" object:zone];
}

- (void) zoneManager:(id<IBZoneManager>)manager didChangedCurrentZones:(NSArray*)zones{
//    NSLog(@"zoneManager didChangedCurrentZones %@",zones);
    UILocalNotification *ln = [[UILocalNotification alloc] init];
    ln.alertBody = [NSString stringWithFormat:@"didChangedCurrentZones - %@", zones];
    ln.fireDate = [NSDate date];
    [[UIApplication sharedApplication] scheduleLocalNotification:ln];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didChangedCurrentZones" object:zones];
}

- (void) zoneManager:(id<IBZoneManager>)manager didFailWithError:(IBError*)error{
//    NSLog(@"zoneManager didFailWithError %@",error);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"zoneManagerDidFailWithError" object:error];
}

- (void) zoneManager:(id<IBZoneManager>)manager didUpdateBeacons:(NSArray*)beacons {
//    NSLog(@"zoneManager didFailWithError %@",beacons);
//    UILocalNotification *ln = [[UILocalNotification alloc] init];
//    ln.alertBody = [NSString stringWithFormat:@"didUpdateBeacons - %lu", (unsigned long)beacons.count];
//    ln.fireDate = [NSDate date];
//    [[UIApplication sharedApplication] scheduleLocalNotification:ln];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didUpdateBeacons" object:nil];
}
@end
