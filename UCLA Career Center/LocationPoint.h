//
//  LocationPoint.h
//  UCLA Career Center
//
//  Created by Jamey Roland on 2/11/14.
//  Copyright (c) 2014 Ricky Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface LocationPoint : NSObject <MKAnnotation>

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@end
