//
//  LocationPoint.m
//  UCLA Career Center
//
//  Created by Jamey Roland on 2/11/14.
//  Copyright (c) 2014 Ricky Yu. All rights reserved.
//

#import "LocationPoint.h"

@implementation LocationPoint

@synthesize coordinate, title;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t
{
    self = [super init];
    if (self) {
        coordinate = c;
        [self setTitle:t];
    }
    return self;
}

- (id)init
{
    CLLocationCoordinate2D careerCenterCoordinates = [self getLocationFromAddressString:@"501 Westwood Plaza, Los Angeles, CA"];
    CLLocationDegrees latitude = careerCenterCoordinates.latitude;
    CLLocationDegrees longitude = careerCenterCoordinates.longitude;
    return [self initWithCoordinate:CLLocationCoordinate2DMake(latitude, longitude) title:@"UCLA Career Center"];
}

- (CLLocationCoordinate2D) getLocationFromAddressString:(NSString*) addressStr {
    
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude = latitude;
    center.longitude = longitude;
    return center;
    
}
@end
