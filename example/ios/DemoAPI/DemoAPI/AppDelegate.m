//
//  AppDelegate.m
//  DemoAPI
//
//  Copyright © 2014-2016 iBecom. All rights reserved.
//

#import "AppDelegate.h"
#import "IBApi.h"
#import <CoreBluetooth/CoreBluetooth.h>


@interface AppDelegate ()<CBCentralManagerDelegate,IBLocationMonitoringConsumer>
@property (strong, nonatomic)CBCentralManager *bluetoothManager;
@property (strong) NSString* consumerId;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //bluetooth status notification
    self.bluetoothManager = [[CBCentralManager alloc] init];
    self.bluetoothManager.delegate = self;

    //init JSON
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"beacons_room" ofType:@"json"];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"beacons" ofType:@"json"];
    NSData *data =  [NSData dataWithContentsOfFile:filePath];
    //init API
    IBError *error = [IBApi initApiWithData:data andKey:@"AwHQNNmTV+LNa2N9McWVRlg2odUKSlUNX8ni6L66YeCUjbI5SYYUabNpi14VfzOei9Cbwe/XEyqa6LyhbItwJHAqBLMZ+ljY4O2wRYI0PHkloC4c2rf0H3P73CBIt5UY3qg="];//full lic up to 27/07/2016
    if (error) {
        UIAlertView *allert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [allert show];
        NSLog(@"%@",error);
    }
//    BOOL isRegisteredForPush = [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
//    
//    if (!isRegisteredForPush) {
//        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIRemoteNotificationTypeNewsstandContentAvailability) categories:nil]];
//        [[UIApplication sharedApplication] registerForRemoteNotifications];
//    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    if (central.state != CBCentralManagerStatePoweredOn) {
        UIAlertView *allert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"bluetooth off" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [allert show];
    }
}

#pragma mark IBLocationMonitoringConsumer
- (void) locationManager:(id<IBLocationManager>)manager didFailWithError:(IBError*)error {
    NSLog(@"locationManager didFailWithError %@",  error);
}

- (void) locationManager:(id<IBLocationManager>)manager didChangeLocation:(id<IBLocation>)location{
    NSLog(@"locationManager didChangeLocation %@",  location);
}
@end
