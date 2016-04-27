//
//  IB2Error.h
//  IBApi
//
//  Created by Alexey Shcherbinin on 14.10.14.
//  Copyright (c) 2014 iBecom. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, IBErrorType) {
    IBErrorGeneralProblem,
    IBErrorUpperLevelNestedProblem,
    IBErrorAPIAlreadyInitialized,
    IBErrorAPIInitializationProblem,
    IBErrorZoneMonitoringProblem,
    IBErrorLocationCalculatorCreationProblem,
    IBErrorDataPreparationProblem,
    IBErrorLocationDeterminationProblem,
    IBErrorUnsupportedConfiguration
};

@interface IBError : NSObject
-(id)initWithType:(IBErrorType)type;
-(id)initWithType:(IBErrorType)type details:(NSString*)details;

@property (readonly) NSString* description;
@property (readonly) IBErrorType type;
@property (readonly) NSString* details;
@end
