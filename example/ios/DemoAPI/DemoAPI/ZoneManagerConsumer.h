//
//  ZoneManagerConsumer.h
//  DemoAPI
//
//  Copyright © 2014-2016 iBecom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBZoneManager.h"

@interface ZoneManagerConsumer : NSObject<IBZoneMonitoringConsumer>

@property (strong) NSString* consumerId;
@property (strong) NSArray* zones;

@property (assign) IB2ZoneSortRule sortRule;

@end
