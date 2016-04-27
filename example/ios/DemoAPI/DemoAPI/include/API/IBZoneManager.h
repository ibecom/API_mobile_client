//
//  IBZoneManager.h
//  IBApi
//
//  Copyright © 2014-2016 iBecom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBError.h"
#import "IBLocation.h"
#import "IBZone.h"

typedef NS_ENUM(NSInteger, IB2ZoneSortRule) {
    IB2ZoneSortRuleTime,
    IB2ZoneSortRulePriority,
    IB2ZoneSortRuleDistance,
    IB2ZoneSortRulePower
};


@protocol IBZoneManager;

@protocol IBZoneMonitoringConsumer <NSObject>

@property (readonly) NSString* consumerId;
@property (readonly) NSArray* zones;

@property (readonly) IB2ZoneSortRule sortRule;

@optional
- (void)zoneManager:(id<IBZoneManager>)manager didChangedCurrentZone:(id<IBZone>)zone;
- (void)zoneManager:(id<IBZoneManager>)manager didChangedCurrentZones:(NSArray*)zones;
- (void)zoneManager:(id<IBZoneManager>)manager didUpdateBeacons:(NSArray*)beacons;

@required
- (void)zoneManager:(id<IBZoneManager>)manager didFailWithError:(IBError*)error;

@end

@protocol IBZoneManager <NSObject>

@property (readonly, nonatomic) NSArray* allZones;

- (void)subscribeConsumer:(id<IBZoneMonitoringConsumer>)consumer;
- (void)unsubscribeConsumer:(id<IBZoneMonitoringConsumer>)consumer;

- (id<IBZone>)currentZoneForConsumer:(id<IBZoneMonitoringConsumer>)consumer;
- (NSArray*)currentZonesForConsumer:(id<IBZoneMonitoringConsumer>)consumer;

- (id<IBZone>)getZoneByIdentifier:(NSNumber*)identifier;

@end