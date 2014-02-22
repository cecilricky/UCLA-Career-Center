//
//  ThirdViewController.m
//  UCLA Career Center
//
//  Created by Jamey Roland on 2/11/14.
//  Copyright (c) 2014 Ricky Yu. All rights reserved.
//

#import "ThirdViewController.h"
#import "LocationPoint.h"
#import <Parse/Parse.h>
@interface ThirdViewController ()
{
    __weak IBOutlet MKMapView *worldView;
    CLLocationManager *locationManager;
    __weak IBOutlet UISegmentedControl *locationDesignator;
}

@end

@implementation ThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDelegate:self];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [locationManager startUpdatingLocation];
    }
    return self;
}

- (void)viewDidLoad
{
    [worldView setShowsUserLocation:YES];
    LocationPoint *careerCenterLocationPoint = [[LocationPoint alloc] init];
    [worldView addAnnotation:careerCenterLocationPoint];
}

#pragma UserDefined
- (IBAction)toggleLocationFocus:(id)sender {
    NSString *titleSegment = [locationDesignator titleForSegmentAtIndex:[locationDesignator selectedSegmentIndex]];
    LocationPoint *careerCenterLocationPoint = [[LocationPoint alloc] init];
    CLLocationDegrees lat = careerCenterLocationPoint.coordinate.latitude;
    CLLocationDegrees lon = careerCenterLocationPoint.coordinate.longitude;
    CLLocation *careerCenterLocation = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
    CLLocation *userLocation = [[CLLocation alloc] initWithLatitude:worldView.userLocation.coordinate.latitude longitude:worldView.userLocation.coordinate.longitude];
    CLLocationDistance range = [careerCenterLocation distanceFromLocation:userLocation] * 2;
    if ([titleSegment isEqualToString:(@"My Location")])
    {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, range, range);
        [worldView setRegion:region animated:YES];
    }
    else
    {
        CLLocationCoordinate2D careerCenterLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lon);
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(careerCenterLocationCoordinate2D, range, range);
        [worldView setRegion:region animated:YES];
    }
}

#pragma CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"Hello");
}

@end
