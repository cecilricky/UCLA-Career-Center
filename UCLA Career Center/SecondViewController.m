//
//  SecondViewController.m
//  UCLA Career Center
//
//  Created by Ricky Yu on 2/8/14.
//  Copyright (c) 2014 Ricky Yu. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize contactInformation;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[self contactInformation] setText:@"\
     UCLA Career Center\n\
     501 Westwood Plaza (at Strathmore), Floors Two and Three\n\
     Los Angeles, CA 90095-1573\n\
     Campus Mail Code 157308\n\
     <h2>Phone: 310.206.1915<\\h2>\n\
     \n\
     Monday through Friday - 9am to 5pm\n\
     For General Questions\n\
     General Information 310.206.1915\n\
     BruinView™ for Alumni Subscription 310.206.1915\n\
     Bruin AlumLink™ 310.206.1915\n\
     Credentials File Service 310.206.1915\n\
     Website Questions and Feedback 310.206.1915\n\
     Media Requests 310.206.1921\n\
     Internship & International Opportunities 310.206.1915\n\
     Graduate & Professional School Fair 310.825.2715\n\
     Career Fairs 310.206.1915\n\
     APSIA Fair 310.206.1915\n\
     For Employers\n\
     Partners and Benefactors Programs 310.206.1935\n\
     BruinView Online Job & Internship Postings 310.206.1902\n\
     BruinView™ Campus Interviews 310.206.1902\n\
     Career Fairs 310.206.1902\n\
     Recruiting at UCLA 310.206.1902\n\
     Advertising Opportunities - Print Publications 310.206.1915"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
