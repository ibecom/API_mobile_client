//
//  LocationManagerViewController.m
//  DemoAPI
//
//  Created by Eugene Kuropatenko on 20.11.15.
//  Copyright © 2015 iBecom. All rights reserved.
//

#import "LocationManagerViewController.h"
#import "IBApi.h"
#import "LocationMonitoringConsumer.h"
#import "IBTimedLocation.h"

@interface LocationManagerViewController ()
@property (strong, nonatomic) LocationMonitoringConsumer *lmConsumer;
@property (weak, nonatomic) IBOutlet UILabel *xLabel;
@property (weak, nonatomic) IBOutlet UILabel *yLabel;
@property (weak, nonatomic) IBOutlet UILabel *zLabel;
@property (weak, nonatomic) IBOutlet UILabel *nLabel;
@property (weak, nonatomic) IBOutlet UILabel *accuracyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *azimuthLabel;

@end

@implementation LocationManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lmConsumer = [LocationMonitoringConsumer new];
    self.lmConsumer.consumerId = @"ddd";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeLocation:) name:@"didChangeLocation" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[IBApi locationManager] subscribeConsumer:self.lmConsumer];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[IBApi locationManager] unsubscribeConsumer:self.lmConsumer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didChangeLocation:(NSNotification*)notification{
    id <IBTimedLocation> location = notification.object;
    self.xLabel.text = [NSString stringWithFormat:@"%f",location.x];
    self.yLabel.text = [NSString stringWithFormat:@"%f",location.y];
    self.zLabel.text = [NSString stringWithFormat:@"%f",location.z];
    self.nLabel.text = [NSString stringWithFormat:@"%f",location.N];
    self.azimuthLabel.text = [NSString stringWithFormat:@"%f",location.azimuth];
    self.accuracyLabel.text = [NSString stringWithFormat:@"%f",location.accuracy];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",[NSDate dateWithTimeIntervalSince1970:location.timestamp/1000]];
    
}

@end
