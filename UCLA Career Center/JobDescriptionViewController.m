//
//  JobDescriptionViewController.m
//  UCLA Career Center
//
//  Created by Gabriel Lopez on 3/2/14.
//  Copyright (c) 2014 Ricky Yu. All rights reserved.
//

#import "JobDescriptionViewController.h"

@interface JobDescriptionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *industriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *gpaLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionLabel;

@end

@implementation JobDescriptionViewController

@synthesize currentJob;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.industriesLabel.text = [self.currentJob industries];
    self.numberLabel.text = [self.currentJob number];
    self.hoursLabel.text = [self.currentJob hours];
    self.gpaLabel.text = [self.currentJob gpa];
    self.descriptionLabel.text = [self.currentJob descrip];
    
    self.title = self.currentJob.name;    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
