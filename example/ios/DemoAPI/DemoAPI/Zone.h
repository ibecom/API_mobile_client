//
//  Zone.h
//  DemoAPI
//
//  Copyright © 2014-2016 iBecom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBApi.h"
@interface Zone : NSObject<IBZone>
@property (readonly, nonatomic) NSString* identifier;
@property (readonly, nonatomic) IB2ZoneState state;
@property (readonly, nonatomic) NSArray *beacons;
@property NSInteger priority;
@property (strong, nonatomic) NSString *name;

- (void) subscribeConsumer:(id<IBZoneStateConsumer>)consumer;
- (void) unsubscribeConsumer:(id<IBZoneStateConsumer>)consumer;

@end
