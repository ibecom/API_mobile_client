//
//  FirstViewController.m
//  DemoAPI
//
//  Copyright © 2014-2016 iBecom. All rights reserved.
//

#import "ZoneManagerViewController.h"
#import "IBApi.h"
#import "IBBeacon.h"
#import "ZoneManagerConsumer.h"
//#import "Zone.h"

@interface ZoneManagerViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (strong, nonatomic) ZoneManagerConsumer *zoneManager;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sortRuleControl;
@property (weak, nonatomic) IBOutlet UISwitch *showBeacons;
@property (weak, nonatomic) IBOutlet UILabel *currentZone;

@end

@implementation ZoneManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangedCurrentZone:) name:@"didChangedCurrentZone" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangedCurrentZones:) name:@"didChangedCurrentZones" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFailWithError:) name:@"zoneManagerDidFailWithError" object:nil];
    
    NSArray *zones = [[IBApi zoneManager] allZones];
    NSMutableArray *monitoringZones = [NSMutableArray array];
    int i = 0;
    for (id <IBZone>zone in zones) {
        [monitoringZones addObject:[zone identifier]];
        [zone setPriority:i++];
    }
    
    if (zones.count) {
        id <IBBeacon>beacon = [[[zones objectAtIndex:0]beacons] firstObject];
        self.regionLabel.text = [[[beacon identity] proximityUUID] UUIDString];
    }
    [self.sortRuleControl setSelectedSegmentIndex:0];
    //add zoneManager
    self.zoneManager = [ZoneManagerConsumer new];
    self.zoneManager.consumerId = @"Zone consumer";
    self.zoneManager.sortRule = IB2ZoneSortRulePriority;
    self.zoneManager.zones = monitoringZones;
    self.showBeacons.on = false;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[IBApi zoneManager] subscribeConsumer:self.zoneManager];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[IBApi zoneManager] unsubscribeConsumer:self.zoneManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)sortRuleSegment:(UISegmentedControl *)sender {
    self.zoneManager.sortRule = sender.selectedSegmentIndex;
    [self.tableView reloadData];
}

- (void)didChangedCurrentZone:(NSNotification*)notification{
    UILocalNotification *ln = [[UILocalNotification alloc] init];
    ln.alertBody = [NSString stringWithFormat:@"VC didChangedCurrentZone - %@", [notification.object identifier]];
    ln.fireDate = [NSDate date];
    [[UIApplication sharedApplication] scheduleLocalNotification:ln];
    self.currentZone.text = [NSString stringWithFormat:@"current zone :%@",[notification.object identifier]];
}

- (void)didChangedCurrentZones:(NSNotification*)notification{
    [self.tableView reloadData];
}

- (void)didUpdateBeacons:(NSNotification*)notification{
     [self.tableView reloadData];
}

- (void)didFailWithError :(NSNotification*)notification{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error" message:notification.description delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [av show];
}

- (IBAction)showBeacons:(UISwitch *)sender {
    if (self.showBeacons.on) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpdateBeacons:) name:@"didUpdateBeacons" object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"didUpdateBeacons" object:nil];
    }
    [self.tableView reloadData];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.zoneManager.zones count];
}

- (id<IBZone>)getZoneInSection:(NSInteger )section {
    NSArray *activeZones = [[IBApi zoneManager] currentZonesForConsumer:self.zoneManager];
    id <IBZone>zone = nil;
    if (activeZones.count && activeZones.count > section ) {
        zone = [activeZones objectAtIndex: section];
    } else {
        int i = 0  ;
        for (id inactiveZone in [self.zoneManager zones]) {
            if (![activeZones containsObject:[[IBApi zoneManager] getZoneByIdentifier:inactiveZone]]) {
                if (i == section -  activeZones.count) {
                    zone = [[IBApi zoneManager] getZoneByIdentifier:inactiveZone];
                    break;
                }
                i++;
            }
        }
    }
    return zone;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.showBeacons.on) {
        id <IBZone>zone = [self getZoneInSection:section];
        return [[zone beacons] count];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"beacon";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    id <IBZone>zone = [self getZoneInSection:indexPath.section];
    id <IBBeacon>beacon = [[zone beacons] objectAtIndex:indexPath.row];
    UILabel *label = [cell viewWithTag:10];
    label.text = [NSString stringWithFormat:@"ID:%@",[[beacon identity] identifier]];
    label = [cell viewWithTag:11];
    label.text = [NSString stringWithFormat:@"Major:%@",[[beacon identity] major]];
    label = [cell viewWithTag:12];
    label.text = [NSString stringWithFormat:@"Minor:%@",[[beacon identity] minor]];
    label = [cell viewWithTag:13];
    label.text = [NSString stringWithFormat:@"available:%d",[beacon available]]; 
    label = [cell viewWithTag:15];
    label.text = [NSString stringWithFormat:@"rssi:%f",[beacon rssi]];
    cell.backgroundColor = [beacon available] ? [UIColor whiteColor] : [UIColor lightGrayColor];
    return cell;
}



#pragma mark UITableViewDelegate
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *cellIdentifier = @"zone";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    UIView *view = [cell.subviews firstObject];
    id <IBZone>zone = [self getZoneInSection:section];
    UILabel *label = [cell viewWithTag:12];
    UIColor *labelColor = nil;
    switch ([zone state]) {
        case IB2ZoneStateInside:
            label.text = @"State : Inside";
            view.backgroundColor = [UIColor greenColor];
            labelColor = [UIColor blackColor];
            break;
        case IB2ZoneStateOutside:
            label.text = @"State : Outside";
            view.backgroundColor = [UIColor whiteColor];
            labelColor = [UIColor lightGrayColor];
            break;
        case IB2ZoneStateUnknown:
            label.text = @"State : Unknown";
            view.backgroundColor = [UIColor whiteColor];
            labelColor = [UIColor lightGrayColor];
            break;
            
        default:
            label.text = @"State: - ";
            labelColor = [UIColor lightGrayColor];
            break;
    }
    label.textColor = labelColor;
    label = [cell viewWithTag:10];
    label.text = [NSString stringWithFormat:@"Identifier:%@",[zone identifier]];
    label.textColor = labelColor;
    label = [cell viewWithTag:13];
    label.textColor = labelColor;
    label.text = [NSString stringWithFormat:@"priority : %ld",(long)[zone priority]];
    
    return view;
}
@end
