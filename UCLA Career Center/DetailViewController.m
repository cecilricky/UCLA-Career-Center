//
//  DetailViewController.m
//  HTMLParsing
//
//  Created by Matt Galloway on 19/05/2012.
//  Copyright (c) 2012 Swipe Stack Ltd. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController (){
    
}
@end

@implementation DetailViewController

@synthesize selecturl;

- (void)viewDidLoad
{
    [super viewDidLoad];
  //  NSString *fullURL = @"https://secure.career.ucla.edu/Login/Default.aspx?AppID=4";
    NSURL *url = [NSURL URLWithString:selecturl];
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