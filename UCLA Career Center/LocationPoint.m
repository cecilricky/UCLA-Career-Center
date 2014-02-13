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
    CLLocationDegrees latitude = 34.06858;
    CLLocationDegrees longitude = -118.44528;
    return [self initWithCoordinate:CLLocationCoordinate2DMake(latitude, longitude) title:@"UCLA Career Center"];
}

@end
