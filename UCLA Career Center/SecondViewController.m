//
//  SecondViewController.m
//  UCLA Career Center
//  https://secure.career.ucla.edu/Login/Default.aspx?AppID=4
//  Created by Ricky Yu on 2/8/14.
//  Copyright (c) 2014 Ricky Yu. All rights reserved.
//

#import "SecondViewController.h"
#import <Parse/Parse.h>

@interface SecondViewController () {
}

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *fullURL = @"https://secure.career.ucla.edu/Login/Default.aspx?AppID=4";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_viewWeb loadRequest:requestObj];
    
//    PFQueryTableViewController *controller = [[PFQueryTableViewController alloc]
//                                              initWithClassName:@"Job"];
//
//    table.window.rootViewController = controller;
//    [table.window makeKeyAndVisible];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
