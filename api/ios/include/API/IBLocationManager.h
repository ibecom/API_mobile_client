//
//  IBLocationManager.h
//  IBApi
//
//  Copyright © 2014-2016 iBecom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBLocation.h"
#import "IBError.h"

@protocol IBLocationManager;

@protocol IBLocationMonitoringConsumer <NSObject>
@property (readonly) NSString* consumerId;
@optional
- (void)locationManager:(id<IBLocationManager>)manager didChangeLocation:(id<IBLocation>)location;
@required
- (void)locationManager:(id<IBLocationManager>)manager didFailWithError:(IBError*)error;
@end

@protocol IBLocationManager <NSObject>

@property (readonly, nonatomic) id<IBLocation> lastLocation;
@property (readonly, nonatomic)  NSArray* allBeacons;

- (void)subscribeConsumer:(id<IBLocationMonitoringConsumer>)consumer;
- (void)unsubscribeConsumer:(id<IBLocationMonitoringConsumer>)consumer;

@end
