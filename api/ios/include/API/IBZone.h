//
//  IBZone.h
//  IBApi
//
//  Copyright © 2014-2016 iBecom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBError.h"

typedef NS_ENUM(NSInteger, IB2ZoneState) {
    IB2ZoneStateInside,
    IB2ZoneStateOutside,
    IB2ZoneStateUnknown
};

@protocol IBZone;

@protocol IBZoneStateConsumer <NSObject>

@property (readonly) NSString* consumerId;

@optional
-(void)zone:(id<IBZone>)zone didChangeState:(IB2ZoneState)state;

@required
-(void)zone:(id<IBZone>)zone didFailWithError:(IBError*)error;

@end

@protocol IBZone <NSObject>
@property (readonly, nonatomic) NSString* identifier;
@property (readonly, nonatomic) IB2ZoneState state;
@property (readonly, nonatomic) NSArray *beacons;
@property NSInteger priority;

- (void)subscribeConsumer:(id<IBZoneStateConsumer>)consumer;
- (void)unsubscribeConsumer:(id<IBZoneStateConsumer>)consumer;

@end