//
//  LocationMonitoringConsumer.h
//  DemoAPI
//
//  Created by Eugene Kuropatenko on 24.11.15.
//  Copyright © 2015 iBecom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBApi.h"

@interface LocationMonitoringConsumer : NSObject<IBLocationMonitoringConsumer>
@property (strong) NSString* consumerId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSDate *creation;

@end
