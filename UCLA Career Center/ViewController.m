//
//  ViewController.m
//  UCLA Career Center
//
//  Created by Tushar Shrimali on 3/9/14.
//  Copyright (c) 2014 Ricky Yu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize myTableViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)createTableViewController {
    [self addChildViewController:myTableViewController];
    [self.view addSubview:myTableViewController.tableView];
    [myTableViewController didMoveToParentViewController:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray * imageArray  = [[NSArray alloc] initWithObjects:
                             [UIImage imageNamed:@"img1.png"],
                             [UIImage imageNamed:@"img2.png"],
                             [UIImage imageNamed:@"img3.png"],
                             [UIImage imageNamed:@"img4.png"],
                             nil];
//    _ImageSection = [[UIImageView alloc] initWithFrame:
//                             CGRectMake(100, 125, 150, 130)];
    _ImageSection.animationImages = imageArray;
    _ImageSection.animationDuration = 15;
    [self.view addSubview:_ImageSection];
    [_ImageSection startAnimating];
	// Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
