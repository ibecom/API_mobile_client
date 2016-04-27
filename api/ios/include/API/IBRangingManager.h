//
//  IBRangingManager.h
//  IBApi
//
//  Copyright © 2014-2016 iBecom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBError.h"
#import "IBBeaconIdentity.h"

@protocol IBRangingManager;

@protocol IBRangingConsumer <NSObject>

@property (readonly) NSString* consumerId;

@optional
- (void)rangingManager:(id<IBRangingManager>)manager didUpdateBeacons:(NSArray*)beacons forConsumer:(id<IBRangingConsumer>)consumer;
- (void)rangingManager:(id<IBRangingManager>)manager didUpdateRegions:(NSArray*)regions forConsumer:(id<IBRangingConsumer>)consumer;
@property (readonly) NSArray* beacons;
@property (readonly) NSArray* regions;

@required
- (void)rangingManager:(id<IBRangingManager>)manager didFailWithError:(IBError*)error;

@end

@protocol IBRangingManager <NSObject>

- (void)registerConsumer:(id<IBRangingConsumer>)consumer;
- (void)unregisterConsumer:(id<IBRangingConsumer>)consumer;

- (void)subscribeConsumer:(id<IBRangingConsumer>)consumer;
- (void)unsubscribeConsumer:(id<IBRangingConsumer>)consumer;

- (NSArray*)getCurrentBeaconsForConsumer:(id<IBRangingConsumer>)consumer;

- (NSArray*)getCurrentRegionsForConsumer:(id<IBRangingConsumer>)consumer;
- (NSArray*)getAllRegionsForConsumer:(id<IBRangingConsumer>)consumer;

- (id<IBBeaconIdentity>)createIdentity;
@end
