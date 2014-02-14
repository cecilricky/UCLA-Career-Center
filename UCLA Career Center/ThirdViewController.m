//
//  ThirdViewController.m
//  UCLA Career Center
//
//  Created by Jamey Roland on 2/11/14.
//  Copyright (c) 2014 Ricky Yu. All rights reserved.
//

#import "ThirdViewController.h"
#import "LocationPoint.h"

@interface ThirdViewController ()
{
    __weak IBOutlet MKMapView *worldView;
    CLLocationManager *locationManager;
    __weak IBOutlet UIButton *careerCenterButton;
    __weak IBOutlet UIButton *locatorButton;
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
    }
    return self;
}

- (void)viewDidLoad
{
    [worldView setShowsUserLocation:YES];
}

#pragma UserDefined

- (IBAction)toggleCareerCenterDisplay:(id)sender {
    
    if ([[careerCenterButton currentTitle]  isEqual: @"Show Career Center"])
        //
    {
        LocationPoint *careerCenterLocation = [[LocationPoint alloc] init];
        [worldView addAnnotation:careerCenterLocation];
        [careerCenterButton setTitle:@"Hide Career Center" forState:UIControlStateNormal];
    }
    else
    {
        [worldView removeAnnotations:[worldView annotations]];
        [careerCenterButton setTitle:@"Show Career Center" forState:UIControlStateNormal];
    }
}
- (IBAction)findUser:(id)sender {
    
    CLLocationCoordinate2D loc = [[worldView userLocation] coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    [worldView setRegion:region animated:YES];
}

@end
