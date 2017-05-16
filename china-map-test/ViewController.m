//
//  ViewController.m
//  china-map-test
//
//  Created by Shih Yun Shen on 16/05/2017.
//  Copyright © 2017 Panobike. All rights reserved.
//

#import "ViewController.h"
#import "LocationManager.h"
#import <JZLocationConverter/JZLocationConverter.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController ()
@property (strong, nonatomic) MKPointAnnotation *annotation;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[LocationManager manager] authorizeIfNecessary];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)dropPinTo:(CLLocationCoordinate2D)coordinate {
    for (id annotation in self.mapView.annotations) {
        [self.mapView removeAnnotation:annotation];
    }
    
    if (!self.annotation) {
        self.annotation = [[MKPointAnnotation alloc] init];
    }
    self.annotation.coordinate = coordinate;
    [self.mapView addAnnotation:self.annotation];
}

- (IBAction)valueChanged:(id)sender {
    CLLocationCoordinate2D coordinate = [[LocationManager manager] currentLocation];

    UISegmentedControl *seg = (UISegmentedControl*)sender;
    if(seg.selectedSegmentIndex == 0) {
        
    } else if (seg.selectedSegmentIndex == 1) {
        coordinate = [JZLocationConverter wgs84ToGcj02:coordinate];
    } else {
        coordinate = [JZLocationConverter gcj02ToWgs84:coordinate];
    }
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [self.mapView setRegion:region animated:YES];
    
    [self dropPinTo:coordinate];

}

@end
