//
//  IBBeaconIdentity.h
//  IBApi
//
//  Copyright © 2014-2016 iBecom. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IBBeaconIdentity <NSObject>
@property NSString* identifier;
@property NSUUID* proximityUUID;
@property NSNumber* major;
@property NSNumber* minor;
@end
