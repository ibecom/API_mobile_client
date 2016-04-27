//
//  IBApi.h
//  IBApi
//
//  Copyright © 2014-2016 iBecom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBZoneManager.h"
#import "IBLocationManager.h"
#import "IBRangingManager.h"
#import "IBError.h"

@interface IBApi : NSObject
+ (NSString*) versionString;

+ (IBError*) initApiWithData:(id)data andKey:(NSString *)key;

+ (id<IBZoneManager>) zoneManager;
+ (id<IBLocationManager>) locationManager;
+ (id<IBRangingManager>) rangingManager;

+ (void)releaseApi;
+ (BOOL)isInitialized;
@end
